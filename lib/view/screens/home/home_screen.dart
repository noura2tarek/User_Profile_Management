import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_profile_management/view/screens/edit_user/edit_user_screen.dart';
import 'package:user_profile_management/controller/api_service.dart';
import 'package:user_profile_management/model/user_model.dart';
import 'package:user_profile_management/view/screens/profile/profile_screen.dart';
import 'package:user_profile_management/view/widgets/custom_list_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];
  bool isLoading = false;

  /*---------- Get Users Data from Cache ----------*/
  Future<List<User>> _getUsersDataFromCache() async {
    // try to load data from shared preferences
    List<User> cachedUsers = [];
    final prefs = await SharedPreferences.getInstance();
    String data = prefs.getString('usersData') ?? '';
    if (data.isEmpty) {
      // data hasn't been saved in shared preferences yet
      log('no data found in cache');
      return cachedUsers;
    } else {
      log('There is data in cache');
      // Convert string to json
      var jsonData = jsonDecode(data);
      jsonData.forEach((item) {
        cachedUsers.add(User.fromJson(item));
      });
      return cachedUsers;
    }
  }

  /*---------- Get Users Data from API ----------*/
  Future<void> _getData() async {
    setState(() {
      isLoading = true;
    });
    List<User> cachedUsers = await _getUsersDataFromCache();
    if (cachedUsers.isNotEmpty) {
      // If data found in shared preferences
      setState(() {
        users = cachedUsers;
        isLoading = false;
      });
    } else {
      List<User> apiUsers = await ApiService().getUsersData();
      setState(() {
        users = apiUsers;
        isLoading = false;
      });
    }
  }

  /*---------- Add User method ----------*/
  void _addUser(User user) async {
    try {
      await ApiService().addUser(user.toJson());
      setState(() {
        users.add(user);
      });
    } catch (e) {
      print('Failed to add user: $e');
    }
  }

  /*---------- Update User method ----------*/
  void _updateUser(User user) async {
    try {
      await ApiService().updateUser(user.id, user.toJson());
      setState(() {
        final index = users.indexWhere((u) => u.id == user.id);
        users[index] = user;
      });
    } catch (e) {
      print('Failed to update user: $e');
    }
  }

  /*---------- Add or edit User method ----------*/
  void _navigateToAddOrUpdateUserScreen({User? user}) async {
    final formResult = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddOrUpdateUserScreen(user: user),
        );
      },
    );

    if (formResult != null && formResult is Map<String, dynamic>) {
      if (formResult['action'] == 'add') {
        _addUser(formResult['user']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User Added successfully!"),
          ),
        );
      } else if (formResult['action'] == 'edit') {
        _updateUser(formResult['user']);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User Updated successfully!"),
          ),
        );
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Color myColor = Color.fromARGB(255, 152, 70, 155);
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.person),
        title: const Text("User List"),
        backgroundColor: myColor,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : users.isEmpty
              ? const Center(child: Text("No users available"))
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = users[index];
                    return Dismissible(
                      key: ValueKey(user.id),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) async {
                        // Show dialog for confirmation
                        return await buildShowDialog(context);
                      },
                      onDismissed: (direction) {
                        // Confirm Delete user method
                        ApiService().deleteUser(user.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${users[index].name} deleted"),
                          ),
                        );
                        setState(() {
                          users.removeAt(index);
                        });
                      },
                      // Delete Icon UI
                      background: Container(
                        color: const Color.fromARGB(183, 241, 37, 22),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.delete, color: Colors.white),
                            const Text(
                              'Delete',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      child: Card(
                        child: CustomListTile(
                          user: user,
                          color: myColor,
                          onTabEdit: () {
                            // Edit user from edit icon
                            _navigateToAddOrUpdateUserScreen(user: user);
                          },
                          onLongPress: () {
                            // Or edit user by long press
                            _navigateToAddOrUpdateUserScreen(user: user);
                          },
                          onTab: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(
                                  user: user,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddOrUpdateUserScreen();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  //////////////////////////////////////
  /*-------------- Build Show alert dialog -------------*/
  Future<bool?> buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete User"),
          content: const Text("Are you sure you want to delete this user?"),
          actions: [
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
