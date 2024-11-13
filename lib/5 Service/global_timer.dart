import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:provider/provider.dart';

class GlobalTimer {
  static final GlobalTimer _instance = GlobalTimer._internal();

  factory GlobalTimer() {
    return _instance;
  }

  GlobalTimer._internal();

  Timer? _timer;

  final List<int> activeTimerTaskId = [];

  void startStopTimer({
    required BuildContext context,
    required TaskModel taskModel,
  }) {
    taskModel.isTimerActive = !taskModel.isTimerActive!;

    if (taskModel.isTimerActive!) {
      activeTimerTaskId.add(taskModel.id);
    } else {
      activeTimerTaskId.remove(taskModel.id);
    }

    startStopGlobalTimer(context);
  }

  void startStopGlobalTimer(BuildContext context) {
    final TaskProvider taskProvider = context.read<TaskProvider>();

    if (_timer != null && _timer!.isActive && (activeTimerTaskId.isEmpty)) {
      _timer!.cancel();
    } else if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          for (var id in activeTimerTaskId) {
            taskProvider.taskList[id].currentDuration = taskProvider.taskList[id].currentDuration! + const Duration(seconds: 1);

            // tamamlandı olarak işaretle
            if (taskProvider.taskList[id].currentDuration! >= taskProvider.taskList[id].remainingDuration!) {
              taskProvider.taskList[id].isCompleted = true;
            }

            context.read<TaskProvider>().updateItems();

            // her dakika veri tabanı güncelle
            if (taskProvider.taskList[id].currentDuration!.inSeconds % 60 == 0) {
              // TODO: update database

              // TODO: task tamamnlandıysa bildirim veya alarm
            }
          }
        },
      );
    }
  }
}
