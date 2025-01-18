import 'package:flutter/material.dart';
import 'package:user_profile_management/controller/user_service.dart';
import 'package:user_profile_management/model/user_model.dart';
import 'package:user_profile_management/view/screens/edit_user/edit_user_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final UserController _userController = UserController();

  @override
  void initState() {
    super.initState();
    _userController.fetchUsers().then((_) {
      setState(() {});
    });
  }

  void _navigateToAddOrUpdateUserScreen({User? user}) async {
    final formResult = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddOrUpdateUserScreen(
          user: user,
        ),
      ),
    );

    if (formResult != null && formResult is Map<String, dynamic>) {
      if (formResult['action'] == 'add') {
        await _userController.addUser(formResult['user']);
      } else if (formResult['action'] == 'edit') {
        await _userController.updateUser(formResult['user']);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: _userController.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _userController.users.length,
              itemBuilder: (BuildContext context, int index) {
                final user = _userController.users[index];
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () =>
                            _navigateToAddOrUpdateUserScreen(user: user),
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () async {
                          await _userController.deleteUser(user.id);
                          setState(() {});
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddOrUpdateUserScreen(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
