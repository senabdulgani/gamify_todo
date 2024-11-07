import 'package:flutter/material.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';

class RutinModel {
  final int id; // id si
  final String title; // başlığı
  final TaskTypeEnum type; // türü
  final DateTime createdDate; // oluşturulma tarihi
  final DateTime startDate; // başlama tarihi
  final TimeOfDay? time; // saati
  final bool isNotificationOn; // notification açık mı
  final Duration? remainingDuration; // timer ise hedef süre timer değilse tecrübe puanı buna göre gelecek
  final int? targetCount; // counter ise hedef sayı
  final List<int> repeatDays; // tekrar günleri
  final List<int>? attirbuteIDList; // etki edeceği özellikler
  final List<int>? skillIDList; // etki edecği yetenekler
  final bool isCompleted; // tamamlandı mı

  RutinModel({
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
