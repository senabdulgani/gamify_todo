import 'package:flutter/material.dart';
import 'package:gamify_todo/7%20Enum/task_status_enum.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';

class TaskModel {
  int id; // id si
  final int? routineID; // eğer varsa rutin id si
  String title; // başlığı
  final TaskTypeEnum type; // türü
  DateTime taskDate; // yapılacağı tarih
  final TimeOfDay? time; // saati
  final bool isNotificationOn; // notification açık mı
  Duration? currentDuration; // timer ise süre buradan takip edilecek
  final Duration? remainingDuration; // timer ise hedef süre timer değilse tecrübe puanı buna göre gelecek
  int? currentCount; // counter ise sayı buradan takip edilecek
  final int? targetCount; // counter ise hedef sayı
  bool? isTimerActive; // timer aktif mi
  List<int>? attributeIDList; // etki edeceği özellikler
  List<int>? skillIDList; // etki edecği yetenekler
  TaskStatusEnum? status; // tamamlandı mı

  TaskModel({
    this.id = 0,
    this.routineID,
    required this.title,
    required this.type,
    required this.taskDate,
    this.time,
    required this.isNotificationOn,
    this.currentDuration,
    this.remainingDuration,
    this.currentCount,
    this.targetCount,
    this.isTimerActive,
    this.attributeIDList,
    this.skillIDList,
    this.status,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    Duration stringToDuration(String timeString) {
      List<String> split = timeString.split(':');
      return Duration(hours: int.parse(split[0]), minutes: int.parse(split[1]), seconds: int.parse(split[2]));
    }

    final TaskTypeEnum type = TaskTypeEnum.values.firstWhere((e) => e.toString().split('.').last == json['type']);

    return TaskModel(
      id: json['id'],
      routineID: json['routine_id'],
      title: json['title'],
      type: type,
      taskDate: DateTime.parse(json['task_date']).toLocal(),
      time: json['time'] != null ? TimeOfDay.fromDateTime(DateTime.parse("1970-01-01 ${json['time']}")) : null,
      isNotificationOn: json['is_notification_on'],
      currentDuration: json['current_duration'] != null ? stringToDuration(json['current_duration']) : null,
      remainingDuration: json['remaining_duration'] != null ? stringToDuration(json['remaining_duration']) : null,
      currentCount: json['current_count'],
      targetCount: json['target_count'],
      isTimerActive: json['is_timer_active'] ?? (type == TaskTypeEnum.TIMER ? false : null),
      attributeIDList: json['attribute_id_list'] != null ? (json['attribute_id_list'] as List).map((i) => i as int).toList() : null,
      skillIDList: json['skill_id_list'] != null ? (json['skill_id_list'] as List).map((i) => i as int).toList() : null,
      status: json['status'] != null ? TaskStatusEnum.values.firstWhere((e) => e.toString().split('.').last == json['status']) : null,
    );
  }

  static List<TaskModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((i) => TaskModel.fromJson(i)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'routine_id': routineID,
      'title': title,
      'type': type.toString().split('.').last,
      'task_date': taskDate.toIso8601String(),
      'time': time != null ? "${time!.hour.toString().padLeft(2, '0')}:${time!.minute.toString().padLeft(2, '0')}:00" : null,
      'is_notification_on': isNotificationOn,
      'current_duration': currentDuration != null ? "${currentDuration!.inHours.toString().padLeft(2, '0')}:${currentDuration!.inMinutes.remainder(60).toString().padLeft(2, '0')}:${currentDuration!.inSeconds.remainder(60).toString().padLeft(2, '0')}" : null,
      'remaining_duration': remainingDuration != null ? "${remainingDuration!.inHours.toString().padLeft(2, '0')}:${remainingDuration!.inMinutes.remainder(60).toString().padLeft(2, '0')}:${remainingDuration!.inSeconds.remainder(60).toString().padLeft(2, '0')}" : null,
      'current_count': currentCount,
      'target_count': targetCount,
      'attribute_id_list': attributeIDList,
      'skill_id_list': skillIDList,
      'status': status?.index,
    };
  }
}
