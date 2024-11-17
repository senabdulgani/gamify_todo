import 'dart:async';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/7%20Enum/task_status_enum.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';

class GlobalTimer {
  static final GlobalTimer _instance = GlobalTimer._internal();

  factory GlobalTimer() {
    return _instance;
  }

  GlobalTimer._internal();

  Timer? _timer;

  void startStopTimer({
    required TaskModel taskModel,
  }) {
    taskModel.isTimerActive = !taskModel.isTimerActive!;

    startStopGlobalTimer();
  }

  void startStopGlobalTimer() {
    final bool isAllTimersOff = !TaskProvider().taskList.any((element) => element.isTimerActive != null && element.isTimerActive!);

    if (_timer != null && _timer!.isActive && isAllTimersOff) {
      _timer!.cancel();
    } else if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          for (var task in TaskProvider().taskList) {
            if (task.isTimerActive != null && task.isTimerActive == true) {
              task.currentDuration = task.currentDuration! + const Duration(seconds: 1);

              // tamamlandı olarak işaretle
              if (task.currentDuration! >= task.remainingDuration!) {
                task.status = TaskStatusEnum.COMPLETED;
              }

              // her dakika veri tabanında güncelle
              if (task.currentDuration!.inSeconds % 60 == 0) {
                // TODO: update database

                // TODO: task tamamnlandıysa bildirim veya alarm
              }
            }
          }

          TaskProvider().updateItems();
        },
      );
    }
  }
}
