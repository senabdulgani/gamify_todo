import 'package:dio/dio.dart';
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

  static const String _baseUrl = 'http://localhost:3001';

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
    var response = await dio.request(
      // TODO: user id shared pref den alınacak
      // "$_baseUrl/getUser?user_id=${user!.id}",
      "$_baseUrl/getUser?user_id=${1}",
      options: Options(
        method: 'GET',
      ),
    );

    checkRequest(response);

    return UserModel.fromJson(response.data[0]);
  }

  // get items
  Future<List<ItemModel>> getItems() async {
    var response = await dio.request(
      "$_baseUrl/getItems?user_id=${user!.id}",
      options: Options(
        method: 'GET',
      ),
    );

    checkRequest(response);

    return (response.data as List).map((e) => ItemModel.fromJson(e)).toList();
  }

  // get traits
  Future<List<TraitModel>> getTraits() async {
    var response = await dio.request(
      "$_baseUrl/getTraits?user_id=${user!.id}",
      options: Options(
        method: 'GET',
      ),
    );

    checkRequest(response);

    return (response.data as List).map((e) => TraitModel.fromJson(e)).toList();
  }

  // get routines
  Future<List<RoutineModel>> getRoutines() async {
    var response = await dio.request(
      "$_baseUrl/getRoutines?user_id=${user!.id}",
      options: Options(
        method: 'GET',
      ),
    );

    checkRequest(response);

    return (response.data as List).map((e) => RoutineModel.fromJson(e)).toList();
  }

  // get tasks
  Future<List<TaskModel>> getTasks() async {
    var response = await dio.request(
      "$_baseUrl/getTasks?user_id=${user!.id}",
      options: Options(
        method: 'GET',
      ),
    );

    checkRequest(response);

    return (response.data as List).map((e) => TaskModel.fromJson(e)).toList();
  }

  Future<void> addTask({
    required TaskModel taskModel,
  }) async {
    var response = await dio.request(
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
      options: Options(
        method: 'POST',
      ),
    );

    checkRequest(response);
  }

  // !!!!!!!!!!!!!!!!!!!! for example !!!!!!!!!!!!!!!!!!!!

  // // get all genres
  // Future<List<GenreModel>> getGenres() async {
  //   var response = await dio.request(
  //     "$_baseUrl/genre",
  //     options: Options(
  //       method: 'GET',
  //     ),
  //   );

  //   checkRequest(response);

  //   return (response.data as List).map((e) => GenreModel.fromJson(e)).toList();
  // }

  // // get all movie
  // Future<List<ContentModel>> getAllMovie() async {
  //   var response = await dio.request(
  //     "$_baseUrl/movie",
  //     options: Options(
  //       method: 'GET',
  //     ),
  //   );

  //   checkRequest(response);

  //   return (response.data as List).map((e) => ContentModel.fromJson(e)).toList();
  // }

  // get all movie for showcase with user id
  // Future<List<ShowcaseContentModel>> getExploreContent({
  //   required ContentTypeEnum? contentType,
  //   required int userId,
  // }) async {
  //   var response = await dio.request(
  //     "$_baseUrl/explore?user_id=$userId${contentType != null ? "&content_type_id=${contentType.index + 1}" : ""}",
  //     options: Options(
  //       method: 'GET',
  //     ),
  //   );

  //   checkRequest(response);

  //   return (response.data as List).map((e) => ShowcaseContentModel.fromJson(e)).toList();
  // }

  // // add genre
  // Future<void> addGenre(String name) async {
  //   var response = await dio.request(
  //     "$_baseUrl/genre",
  //     data: {
  //       'name': name,
  //     },
  //     options: Options(
  //       method: 'POST',
  //     ),
  //   );

  //   checkRequest(response);
  // }

  //conent_user_action
  // Future<void> contentUserAction({
  //   required ContentLogModel contentLogModel,
  // }) async {
  //   var response = await dio.request(
  //     "$_baseUrl/content_user_action",
  //     data: {
  //       'user_id': contentLogModel.userID,
  //       'content_id': contentLogModel.contentID,
  //       'content_status_id': contentLogModel.contentStatus == null ? null : contentLogModel.contentStatus!.index + 1,
  //       'content_type_id': contentLogModel.contentType.index + 1,
  //       'rating': contentLogModel.rating == 0 ? null : contentLogModel.rating,
  //       'is_favorite': contentLogModel.isFavorite,
  //       'is_consume_later': contentLogModel.isConsumeLater,
  //       'review': contentLogModel.review,
  //     },
  //     options: Options(
  //       method: 'POST',
  //     ),
  //   );

  //   checkRequest(response);
  // }

  // Future<ContentModel> getContentDetail({
  //   required int contentId,
  //   required ContentTypeEnum contentType,
  //   int? userId,
  // }) async {
  //   var response = await dio.request(
  //     "$_baseUrl/content_detail?content_id=$contentId&user_id=${userId ?? userID}&content_type_id=${contentType.index + 1}",
  //     options: Options(
  //       method: 'GET',
  //     ),
  //   );

  //   checkRequest(response);

  //   return ContentModel.fromJson(response.data);
  // }
}
