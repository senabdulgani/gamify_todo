import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/accessible.dart';
import 'package:gamify_todo/8%20Model/rutin_model.dart';
import 'package:gamify_todo/8%20Model/store_item_model.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:gamify_todo/8%20Model/trait_model.dart';
import 'package:gamify_todo/8%20Model/user_model.dart';

class ServerManager {
  ServerManager._privateConstructor();

  static final ServerManager _instance = ServerManager._privateConstructor();

  factory ServerManager() {
    return _instance;
  }

  // static const String _baseUrl = 'http://localhost:3001';
  // static const String _baseUrl = 'http://10.103.138.106:3001';
  // static const String _baseUrl = 'http://192.168.1.18:3001';
  static const String _baseUrl = 'https://gamify-273bac1e9487.herokuapp.com';

  var dio = Dio();

  // --------------------------------------------

  // check request
  void checkRequest(Response response) {
    if (response.statusCode == 200) {
      // debugPrint(json.encode(response.data));
    } else {
      debugPrint(response.statusMessage);
    }
  }

  // ********************************************
  // get user
  // TODO: auto login system
  Future<UserModel> getUser() async {
    var response = await dio.get(
      // TODO: user id shared pref den alınacak
      // "$_baseUrl/getUser?user_id=${user!.id}",
      "$_baseUrl/getUser?user_id=${2}",
    );

    checkRequest(response);

    return UserModel.fromJson(response.data[0]);
  }

  // get items
  Future<List<ItemModel>> getItems() async {
    var response = await dio.get(
      "$_baseUrl/getItems?user_id=${user!.id}",
    );

    checkRequest(response);

    return (response.data as List).map((e) => ItemModel.fromJson(e)).toList();
  }

  // get traits
  Future<List<TraitModel>> getTraits() async {
    var response = await dio.get(
      "$_baseUrl/getTraits?user_id=${user!.id}",
    );

    checkRequest(response);

    return (response.data as List).map((e) => TraitModel.fromJson(e)).toList();
  }

  // get routines
  Future<List<RoutineModel>> getRoutines() async {
    var response = await dio.get(
      "$_baseUrl/getRoutines?user_id=${user!.id}",
    );

    checkRequest(response);

    return (response.data as List).map((e) => RoutineModel.fromJson(e)).toList();
  }

  // get tasks
  Future<List<TaskModel>> getTasks() async {
    var response = await dio.get(
      "$_baseUrl/getTasks?user_id=${user!.id}",
    );

    checkRequest(response);

    return (response.data as List).map((e) => TaskModel.fromJson(e)).toList();
  }

// -------------------

// add user
  Future<int> addUser({
    required UserModel userModel,
  }) async {
    try {
      var response = await dio.post(
        "$_baseUrl/addUser",
        data: userModel.toJson(),
      );

      checkRequest(response);

      return response.data['id'];
    } on DioException catch (e) {
      debugPrint('Error adding user: ${e.message}');
      rethrow;
    }
  }

// add item
  Future<int> addItem({
    required ItemModel itemModel,
  }) async {
    try {
      var response = await dio.post(
        "$_baseUrl/addItem",
        queryParameters: {
          'user_id': user!.id,
        },
        data: itemModel.toJson(),
      );

      checkRequest(response);

      return response.data['id'];
    } on DioException catch (e) {
      debugPrint('Error adding item: ${e.message}');
      rethrow;
    }
  }

// add trait
  Future<int> addTrait({
    required TraitModel traitModel,
  }) async {
    try {
      var response = await dio.post(
        "$_baseUrl/addTrait",
        queryParameters: {
          'user_id': user!.id,
        },
        data: traitModel.toJson(),
      );

      checkRequest(response);

      return response.data['id'];
    } on DioException catch (e) {
      debugPrint('Error adding trait: ${e.message}');
      rethrow;
    }
  }

// add routine
  Future<int> addRoutine({
    required RoutineModel routineModel,
  }) async {
    try {
      var response = await dio.post(
        "$_baseUrl/addRoutine",
        queryParameters: {
          'user_id': user!.id,
        },
        data: routineModel.toJson(),
      );

      checkRequest(response);

      return response.data['id'];
    } on DioException catch (e) {
      debugPrint('Error adding routine: ${e.message}');
      rethrow;
    }
  }

// add task
  Future<int> addTask({
    required TaskModel taskModel,
  }) async {
    var response = await dio.post(
      "$_baseUrl/addTask",
      queryParameters: {
        'user_id': user!.id,
      },
      data: taskModel.toJson(),
    );

    checkRequest(response);

    return response.data['id'];
  }

  // ------------------------

  // update user
  Future<void> updateUser({
    required UserModel userModel,
  }) async {
    var response = await dio.put(
      "$_baseUrl/updateUser",
      data: userModel.toJson(),
    );

    checkRequest(response);
  }

  // update items
  Future<void> updateItem({
    required ItemModel itemModel,
  }) async {
    var response = await dio.put(
      "$_baseUrl/updateItem",
      data: itemModel.toJson(),
    );

    checkRequest(response);
  }

  // update trait
  Future<void> updateTrait({
    required TraitModel traitModel,
  }) async {
    var response = await dio.put(
      "$_baseUrl/updateTrait",
      data: traitModel.toJson(),
    );

    checkRequest(response);
  }

  // update routines
  Future<void> updateRoutine({
    required RoutineModel routineModel,
  }) async {
    var response = await dio.put(
      "$_baseUrl/updateRoutine",
      data: routineModel.toJson(),
    );

    checkRequest(response);
  }

  // update tasks
  Future<void> updateTask({
    required TaskModel taskModel,
  }) async {
    var response = await dio.put(
      "$_baseUrl/updateTask",
      data: taskModel.toJson(),
    );

    checkRequest(response);
  }
}
