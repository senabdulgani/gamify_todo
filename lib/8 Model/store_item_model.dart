import 'package:gamify_todo/7%20Enum/task_type_enum.dart';

// !!!! şuan için sadece yapılacak. skillere etki etmeyecek

class StoreItemModel {
  final int id; // id si
  final String title; // başlığı
  final TaskTypeEnum type; // türü
  Duration? currentDuration; // timer ise süre buradan takip edilecek
  final Duration? addDuration; // timer ise hedef süre timer değilse tecrübe puanı buna göre gelecek
  int? currentCount; // counter ise sayı buradan takip edilecek
  final int? addCount; // counter ise hedef sayı
  bool? isTimerActive; // timer aktif mi
  int credit; // timer aktif mi

  StoreItemModel({
    required this.id,
    required this.title,
    required this.type,
    this.currentDuration,
    this.addDuration,
    this.currentCount,
    this.addCount,
    this.isTimerActive,
    required this.credit,
  });
}
