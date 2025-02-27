import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_profile_management/model/user_model.dart';

class ApiService {
  final Dio _dio = Dio();

  // End point url
  String url = 'https://jsonplaceholder.typicode.com/users';

  /*-------------- Add User Data Method ------------*/
  Future<Response> addUser(Map<String, dynamic> data) async {
    return await _dio.post(url, data: data);
  }

  /*-------------- Update User Data Method ------------*/
  Future<Response> updateUser(int id, Map<String, dynamic> data) async {
    return await _dio.put('$url/$id', data: data);
  }

  /*-------------- Delete User Data Method ------------*/
  Future<Response> deleteUser(int id) async {
    return await _dio.delete('$url/$id');
  }

  /*-------------- Get User Data Method ------------*/
  Future<List<User>> getUsersData() async {
    List<User> users = [];
    try {
      var response = await _dio.get(url);
      var data = response.data;
      if (response.statusCode == 200) {
        //convert json to string
        var cachedData = jsonEncode(data);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(
            'usersData', cachedData); //store data in shared preferences
        // Convert json data to list of user model
        data.forEach((user) {
          users.add(User.fromJson(user));
        });
      }
    } on DioException catch (e) {
      // HANDLE ERRORS
      if (e.type == DioExceptionType.badResponse) {
        switch (e.response!.statusCode) {
          case 404:
            log('error: 404 - Not found');
            // Cancels the currently visible toast, if any
            Fluttertoast.cancel();
            showToast(
              message: e.response?.data['message'],
              color: chooseToastColor(ToastStates.ERROR),
            );
            break;
          case 401:
            log('error: 401 - Unauthorized');
            // Cancels the currently visible toast, if any
            Fluttertoast.cancel();
            showToast(
              message: e.response?.data['message'],
              color: chooseToastColor(ToastStates.ERROR),
            );
            break;
          default:
            log('error: ${e.response!.statusCode} - ${e.response?.data['message']}');
            break;
        }
      } else if (e.type == DioExceptionType.connectionError) {
        log('error: Please check your internet connection.');
        // Cancels the currently visible toast, if any
        Fluttertoast.cancel();
        showToast(
          message: 'No internet connection, check your internet and try again',
          color: chooseToastColor(ToastStates.NOTIFY),
        );
      }
    }
    return users;
  }
}
///////////////////// End of Class /////////////////////////

/*---------------- Show Toast Method ---------------*/
Future<bool?> showToast({required String message, Color color = Colors.red}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

// Choose toast color
Color chooseToastColor(ToastStates state) {
  Color color = Colors.red;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.NOTIFY:
      color = Colors.grey;
      break;
  }
  return color;
}

enum ToastStates { SUCCESS, WARNING, NOTIFY, ERROR }
