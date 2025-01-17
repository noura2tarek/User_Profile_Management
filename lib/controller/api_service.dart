import 'package:dio/dio.dart';

class ApiService {
  static const String url = 'https://jsonplaceholder.typicode.com/';
  final Dio _dio = Dio(BaseOptions(baseUrl: url));

  Future<Response> fetchUsers() async {
    return await _dio.get('/users');
  }

  Future<Response> fetchUser(int id) async {
    return await _dio.get('/users/$id');
  }

  Future<Response> updateUser(int id, Map<String, dynamic> data) async {
    return await _dio.put('/users/$id', data: data);
  }

  Future<Response> addUser(Map<String, dynamic> data) async {
    return _dio.post('/users', data: data);
  }
}
