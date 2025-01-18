import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com/'));

  Future<Response> fetchUsers() async {
    return await _dio.get('/users');
  }

  Future<Response> addUser(Map<String, dynamic> data) async {
    return await _dio.post('/users', data: data);
  }

  Future<Response> updateUser(int id, Map<String, dynamic> data) async {
    return await _dio.put('/users/$id', data: data);
  }

  Future<Response> deleteUser(int id) async {
    return await _dio.delete('/users/$id');
  }
}
