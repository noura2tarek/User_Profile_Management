import 'package:user_profile_management/model/user_model.dart';
import 'package:user_profile_management/controller/api_service.dart';

class UserController {
  final ApiService _api = ApiService();

  Future<void> addUser(User user) async {
    try {
      await _api.addUser(user.toJson());
    } catch (e) {
      throw Exception('Failed to add user: $e');
    }
  }

  Future<void> updateUser(User user) async {
    try {
      await _api.updateUser(user.id, user.toJson());
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  Future<List<User>> fetchUsers() async {
    try {
      final response = await _api.fetchUsers();
      return (response.data as List)
          .map((user) => User.fromJson(user))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }
}
