import 'package:flutter/material.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/attirbute_model.dart';

class TaskModel {
  final String title;
  final TaskTypeEnum type;
  final DateTime createDate;
  final TimeOfDay? remainigTime;
  final bool isNotificationOn;
  final Duration? duration;
  final List<int>? repeatDays;
  final List<AttirbuteModel>? attirbuteList;
  final List<AttirbuteModel>? skillList;

  // final TimerData? timerData;
  // final CounterData? counterData;
  // final CheckData? checkData;

  TaskModel({
    required this.title,
    required this.type,
    required this.createDate,
    this.remainigTime,
    this.isNotificationOn = false,
    this.duration,
    this.repeatDays = const [],
    this.attirbuteList,
    this.skillList,

    // this.timerData,
    // this.counterData,
    // this.checkData,
  });
}
