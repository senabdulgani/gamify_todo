import 'package:flutter/material.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';

class RoutineModel {
  final int id; // id si
  String title; // başlığı
  TaskTypeEnum type; // türü
  final DateTime createdDate; // oluşturulma tarihi
  DateTime startDate; // başlama tarihi
  TimeOfDay? time; // saati
  bool isNotificationOn; // notification açık mı
  Duration? remainingDuration; // timer ise hedef süre timer değilse tecrübe puanı buna göre gelecek
  int? targetCount; // counter ise hedef sayı
  List<int> repeatDays; // tekrar günleri
  List<int>? attirbuteIDList; // etki edeceği özellikler
  List<int>? skillIDList; // etki edecği yetenekler
  bool isCompleted; // tamamlandı mı

  RoutineModel({
    required this.id,
    required this.title,
    required this.type,
    required this.createdDate,
    required this.startDate,
    this.time,
    required this.isNotificationOn,
    this.remainingDuration,
    this.targetCount,
    required this.repeatDays,
    this.attirbuteIDList,
    this.skillIDList,
    required this.isCompleted,
  });

  factory RoutineModel.fromJson(Map<String, dynamic> json) {
    TaskTypeEnum type = TaskTypeEnum.values.firstWhere((e) => e.toString().split('.').last == json['type']);

    Duration stringToDuration(String timeString) {
      List<String> split = timeString.split(':');
      return Duration(hours: int.parse(split[0]), minutes: int.parse(split[1]), seconds: int.parse(split[2]));
    }

    return RoutineModel(
      id: json['id'],
      title: json['title'],
      type: type,
      createdDate: DateTime.parse(json['created_date']),
      startDate: DateTime.parse(json['start_date']),
      time: json['time'] != null ? TimeOfDay.fromDateTime(DateTime.parse("1970-01-01 ${json['time']}")) : null,
      isNotificationOn: json['is_notification_on'],
      remainingDuration: json['remaining_duration'] != null ? stringToDuration(json['remaining_duration']) : null,
      targetCount: json['target_count'],
      // repeatDays: List<int>.from(json['repeat_days']),
// Fix List<int> parsing from string array
      repeatDays: (json['repeat_days'] as List).map((e) => int.parse(e.toString())).toList(), attirbuteIDList: json['attirbute_id_list'] != null ? List<int>.from(json['attirbute_id_list']) : null,
      skillIDList: json['skill_id_list'] != null ? List<int>.from(json['skill_id_list']) : null,
      isCompleted: json['is_completed'],
    );
  }
}
