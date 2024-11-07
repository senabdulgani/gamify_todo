import 'package:flutter/material.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';

class TaskModel {
  final int id; // id si
  final int? rutinID; // eğer varsa rutin id si
  final String title; // başlığı
  final TaskTypeEnum type; // türü
  final DateTime taskDate; // yapılacağı tarih
  final TimeOfDay? time; // saati
  final bool isNotificationOn; // notification açık mı
  final Duration? currentDuration; // timer ise süre buradan takip edilecek
  final Duration? remainingDuration; // timer ise hedef süre timer değilse tecrübe puanı buna göre gelecek
  final int? currentCount; // counter ise sayı buradan takip edilecek
  final int? targetCount; // counter ise hedef sayı
  final List<int>? attirbuteIDList; // etki edeceği özellikler
  final List<int>? skillIDList; // etki edecği yetenekler
  final bool? isCompleted; // tamamlandı mı

  TaskModel({
    required this.id,
    this.rutinID,
    required this.title,
    required this.type,
    required this.taskDate,
    this.time,
    required this.isNotificationOn,
    this.currentDuration,
    this.remainingDuration,
    this.currentCount,
    this.targetCount,
    this.attirbuteIDList,
    this.skillIDList,
    required this.isCompleted,
  });
}
