import 'package:dio/dio.dart';

// End point url
String url = 'https://jsonplaceholder.typicode.com/users';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> fetchUsers() async {
    return await _dio.get(url);
  }

  Future<Response> addUser(Map<String, dynamic> data) async {
    return await _dio.post(url, data: data);
  }

  Future<Response> updateUser(int id, Map<String, dynamic> data) async {
    return await _dio.put('$url/$id', data: data);
  }

  Future<Response> deleteUser(int id) async {
    return await _dio.delete('$url/$id');
  }
}
