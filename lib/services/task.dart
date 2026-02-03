import 'dart:convert';

import 'package:api_project/models/task.dart';
import 'package:api_project/models/task_listing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TaskServices {
  final String baseUrl = "";

  ///Create Task
  Future<TaskModel> createTask({
    required String description,
    required String token,
  }) async {
    http.Response response = await http.post(
      Uri.parse('$baseUrl/todos/add'),
      headers: {'Content-Type': 'application/json', 'Authorization': token},
      body: jsonEncode({'description': description}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase.toString());
    }
  }

  ///Get All Task
  Future<TaskListingModel> getAllTask(String token) async {
    http.Response response = await http.get(
      Uri.parse('$baseUrl/todos/get'),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListingModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase.toString());
    }
  }

  ///Get Completed Task
  Future<TaskListingModel> getCompletedTask(String token) async {
    http.Response response = await http.get(
      Uri.parse('$baseUrl/todos/completed'),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListingModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase.toString());
    }
  }

  ///Get InCompleted Task
  Future<TaskListingModel> getInCompletedTask(String token) async {
    http.Response response = await http.get(
      Uri.parse('$baseUrl/todos/incomplete'),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListingModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase.toString());
    }
  }

  ///Search Task
  Future<TaskListingModel> getSearchTask({
    required String token,
    required String searchKeyword,
  }) async {
    http.Response response = await http.get(
      Uri.parse('$baseUrl/todos/search?keywords=$searchKeyword'),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListingModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase.toString());
    }
  }

  ///Filter Task
  Future<TaskListingModel> filterTask({
    required String token,
    required String startDate,
    required String endDate,
  }) async {
    http.Response response = await http.get(
      Uri.parse('$baseUrl/todos/filter?startDate=$startDate&endDate=$endDate'),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskListingModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase.toString());
    }
  }

  ///Delete Task
  Future<bool> deleteTask({
    required String token,
    required String taskId,
  }) async {
    http.Response response = await http.delete(
      Uri.parse('$baseUrl/todos/delete/$taskId'),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception(response.reasonPhrase.toString());
    }
  }

  ///Update Task
  Future<bool> updateTask({
    required String token,
    required String taskId,
    required String description,
    required bool complete,
  }) async {
    http.Response response = await http.patch(
      Uri.parse('$baseUrl/todos/update/$taskId'),
      headers: {'Content-Type': 'application/json', 'Authorization': token},
      body: jsonEncode({'description': description, 'complete': complete}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception(response.reasonPhrase.toString());
    }
  }
}

