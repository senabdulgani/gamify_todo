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
  static const String _baseUrl = 'http://192.168.1.18:3001';

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
  Future<UserModel> getUser() async {
    var response = await dio.get(
      // TODO: user id shared pref den alınacak
      // "$_baseUrl/getUser?user_id=${user!.id}",
      "$_baseUrl/getUser?user_id=${1}",
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
  Future<void> addTask({
    required TaskModel taskModel,
  }) async {
    var response = await dio.post(
      "$_baseUrl/addTask",
      queryParameters: {
        'user_id': user!.id,
      },
      data:
          // {
          // 'routineID': taskModel.routineID,
          // 'title': taskModel.title,
          // 'type': taskModel.type.index + 1,
          // 'taskDate': taskModel.taskDate.toIso8601String(),
          // 'time': taskModel.time,
          // 'isNotificationOn': taskModel.isNotificationOn,
          // 'currentDuration': taskModel.currentDuration?.inSeconds,
          // 'remainingDuration': taskModel.remainingDuration?.inSeconds,
          // 'currentCount': taskModel.currentCount,
          // 'targetCount': taskModel.targetCount,
          // 'isTimerActive': taskModel.isTimerActive,
          // 'attirbuteIDList': taskModel.attirbuteIDList,
          // 'skillIDList': taskModel.skillIDList,
          // 'status': taskModel.status?.index,
          // },
          taskModel.toJson(),
    );

    checkRequest(response);
  }

  // ------------------------

  // edit user
  Future<void> editUser({
    required UserModel userModel,
  }) async {
    var response = await dio.put(
      "$_baseUrl/editUser",
      data: userModel.toJson(),
    );

    checkRequest(response);
  }

  // edit items
  Future<void> editItem({
    required ItemModel itemModel,
  }) async {
    var response = await dio.put(
      "$_baseUrl/editItem",
      data: itemModel.toJson(),
    );

    checkRequest(response);
  }

  // edit trait
  Future<void> editTrait({
    required TraitModel traitModel,
  }) async {
    var response = await dio.put(
      "$_baseUrl/editTrait",
      data: traitModel.toJson(),
    );

    checkRequest(response);
  }

  // edit routines
  Future<void> editRoutine({
    required RoutineModel routineModel,
  }) async {
    var response = await dio.put(
      "$_baseUrl/editRoutine",
      data: routineModel.toJson(),
    );

    checkRequest(response);
  }

  // edit tasks
  Future<void> editTask({
    required TaskModel taskModel,
  }) async {
    var response = await dio.put(
      "$_baseUrl/editTask",
      data: taskModel.toJson(),
    );

    checkRequest(response);
  }
}
