import 'package:flutter/material.dart';
import 'package:user_profile_management/controller/api_service.dart';
import 'package:user_profile_management/model/user_model.dart';
import 'package:user_profile_management/view/screens/edit_user/edit_user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _api = ApiService();
  List<User> _users = [];

  void _updateUser(User user) async {
    try {
      await _api.updateUser(user.id, user.toJson());
      setState(() {
        final index = _users.indexWhere((u) => u.id == user.id);
        _users[index] = user;
      });
    } catch (e) {
      print('Failed to update user: $e');
    }
  }

  void _addUser(User user) async {}

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
        _addUser(formResult['user']);
      } else if (formResult['action'] == 'edit') {
        _updateUser(formResult['user']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
