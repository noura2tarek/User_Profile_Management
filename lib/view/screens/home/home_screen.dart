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
        elevation: 4,
      ),
      body: _userController.loading ? _buildShimmerLoading() : _buildUserList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddOrUpdateUserScreen(),
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue,
        elevation: 4,
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 2,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Container(
              width: 100,
              height: 16,
              color: Colors.grey,
            ),
            subtitle: Container(
              width: 150,
              height: 14,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserList() {
    return ListView.builder(
      itemCount: _userController.users.length,
      itemBuilder: (context, index) {
        final user = _userController.users[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 2,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(
              user.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(user.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => _navigateToAddOrUpdateUserScreen(user: user),
                  icon: const Icon(Icons.edit, color: Colors.blue),
                ),
                IconButton(
                  onPressed: () async {
                    await _userController.deleteUser(user.id);
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
