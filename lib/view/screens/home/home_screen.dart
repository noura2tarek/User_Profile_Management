import 'package:flutter/material.dart';
import 'package:user_profile_management/controller/user_service.dart';
import 'package:user_profile_management/model/user_model.dart';
import 'package:user_profile_management/view/screens/edit_user/edit_user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController _userController = UserController();
  List<User> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    setState(() => _isLoading = true);
    try {
      final users = await _userController.fetchUsers();
      setState(() => _users = users);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch users: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _navigateToAddOrUpdateUserScreen({User? user}) async {
    final formResult = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddOrUpdateUserScreen(user: user),
      ),
    );

    if (formResult != null && formResult is Map<String, dynamic>) {
      if (formResult['action'] == 'add') {
        await _userController.addUser(formResult['user']);
      } else if (formResult['action'] == 'edit') {
        await _userController.updateUser(formResult['user']);
      }
      _fetchUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('User Profiles', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddOrUpdateUserScreen(),
        backgroundColor: const Color.fromARGB(255, 125, 187, 238),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchUsers,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  final user = _users[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Text(
                          user.name[0],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      title: Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(user.email),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () =>
                            _navigateToAddOrUpdateUserScreen(user: user),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
