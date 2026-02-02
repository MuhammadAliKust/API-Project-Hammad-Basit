import 'dart:convert';

import 'package:api_project/models/login.dart';
import 'package:api_project/models/register.dart';
import 'package:api_project/models/user.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  ///Register User
  Future<RegisterModel> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    http.Response response = await http.post(
      Uri.parse('{{TODO_URL}}/users/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegisterModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase.toString());
    }
  }

  ///Login User
  Future<LoginModel> loginUser({
    required String email,
    required String password,
  }) async {
    http.Response response = await http.post(
      Uri.parse('{{TODO_URL}}/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase.toString());
    }
  }

  ///Get User Details
  Future<UserModel> getUser(String token) async {
    http.Response response = await http.get(
      Uri.parse('{{TODO_URL}}/users/profile'),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase.toString());
    }
  }

  ///Update User Details
  Future<UserModel> updateUser({
    required String token,
    required String name,
  }) async {
    http.Response response = await http.put(
      Uri.parse('{{TODO_URL}}/users/profile'),
      headers: {'Authorization': token, 'Content-Type': 'application/json'},
      body: jsonEncode({'name': name}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase.toString());
    }
  }
}
