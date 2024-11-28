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
}
