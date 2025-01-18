import 'package:user_profile_management/controller/api_service.dart';
import 'package:user_profile_management/model/user_model.dart';

class UserController {
  final ApiService _apiService = ApiService();
  List<User> _users = [];
  bool _loading = true;

  List<User> get users => _users;
  bool get loading => _loading;

  Future<void> fetchUsers() async {
    _loading = true;
    try {
      final response = await _apiService.fetchUsers();
      _users =
          (response.data as List).map((json) => User.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching users: $e');
    } finally {
      _loading = false;
    }
  }

  Future<void> addUser(User user) async {
    try {
      await _apiService.addUser(user.toJson());
      _users.add(user);
    } catch (e) {
      print('Failed to add user: $e');
    }
  }

  Future<void> updateUser(User user) async {
    try {
      await _apiService.updateUser(user.id, user.toJson());
      final index = _users.indexWhere((u) => u.id == user.id);
      _users[index] = user;
    } catch (e) {
      print('Failed to update user: $e');
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      await _apiService.deleteUser(id);
      _users.removeWhere((user) => user.id == id);
    } catch (e) {
      print('Failed to delete user: $e');
    }
  }
}
