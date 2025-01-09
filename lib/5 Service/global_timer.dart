import 'dart:async';
import 'package:gamify_todo/5%20Service/app_helper.dart';
import 'package:gamify_todo/5%20Service/server_manager.dart';
import 'package:gamify_todo/6%20Provider/navbar_provider.dart';
import 'package:gamify_todo/6%20Provider/store_provider.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/7%20Enum/task_status_enum.dart';
import 'package:gamify_todo/8%20Model/store_item_model.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalTimer {
  static final GlobalTimer _instance = GlobalTimer._internal();

  factory GlobalTimer() {
    return _instance;
  }

  GlobalTimer._internal();

  Timer? _timer;

  void startStopTimer({
    TaskModel? taskModel,
    ItemModel? storeItemModel,
  }) async {
    if (taskModel != null) {
      taskModel.isTimerActive = !taskModel.isTimerActive!;

      // Timer başlatıldığında zamanı kaydet
      final prefs = await SharedPreferences.getInstance();
      if (taskModel.isTimerActive!) {
        final now = DateTime.now().toIso8601String();
        await prefs.setString('task_last_update_${taskModel.id}', now);
      } else {
        await prefs.remove('task_last_update_${taskModel.id}');
      }
    } else if (storeItemModel != null) {
      storeItemModel.isTimerActive = !storeItemModel.isTimerActive!;

      // Timer başlatıldığında zamanı kaydet
      final prefs = await SharedPreferences.getInstance();
      if (storeItemModel.isTimerActive!) {
        final now = DateTime.now().toIso8601String();
        await prefs.setString('item_last_update_${storeItemModel.id}', now);
      } else {
        await prefs.remove('item_last_update_${storeItemModel.id}');
      }
    }

    startStopGlobalTimer();
  }

  void startStopGlobalTimer() {
    final bool isAllTimersOff = !TaskProvider().taskList.any((element) => element.isTimerActive != null && element.isTimerActive!) && !StoreProvider().storeItemList.any((element) => element.isTimerActive != null && element.isTimerActive!);

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
                // TODO: task tamamnlandıysa bildirim veya alarm

                SharedPreferences.getInstance().then((prefs) {
                  prefs.setString('task_last_update_${task.id}', DateTime.now().toIso8601String());
                });

                ServerManager().updateTask(taskModel: task);

                AppHelper().addCreditByProgress(const Duration(seconds: 60));
              }
            }
          }

          for (var storeItem in StoreProvider().storeItemList) {
            if (storeItem.isTimerActive != null && storeItem.isTimerActive == true) {
              storeItem.currentDuration = storeItem.currentDuration! - const Duration(seconds: 1);

              // her dakika veri tabanında güncelle
              if (storeItem.currentDuration!.inSeconds % 60 == 0) {
                SharedPreferences.getInstance().then((prefs) {
                  prefs.setString('item_last_update_${storeItem.id}', DateTime.now().toIso8601String());
                });

                ServerManager().updateItem(itemModel: storeItem);

                // TODO: task tamamnlandıysa bildirim veya alarm
              }
            }
          }

          if (NavbarProvider().currentIndex == 0) {
            StoreProvider().setStateItems();
          } else if (NavbarProvider().currentIndex == 1) {
            TaskProvider().updateItems();
          }
        },
      );
    }
  }

  Future<void> checkSavedTimers() async {
    final prefs = await SharedPreferences.getInstance();

    for (var task in TaskProvider().taskList) {
      if (task.isTimerActive == true) {
        final lastUpdateStr = prefs.getString('task_last_update_${task.id}');
        if (lastUpdateStr != null) {
          final lastUpdate = DateTime.parse(lastUpdateStr);
          final now = DateTime.now();
          final difference = now.difference(lastUpdate);

          // Son güncelleme ile şimdiki zaman arasındaki farkı ekle
          task.currentDuration = task.currentDuration! + difference;

          // Son güncelleme zamanını güncelle
          await prefs.setString('task_last_update_${task.id}', now.toIso8601String());

          ServerManager().updateTask(taskModel: task);

          AppHelper().addCreditByProgress(difference);
        }
      }
    }

    for (var storeItem in StoreProvider().storeItemList) {
      if (storeItem.isTimerActive == true) {
        final lastUpdateStr = prefs.getString('item_last_update_${storeItem.id}');
        if (lastUpdateStr != null) {
          final lastUpdate = DateTime.parse(lastUpdateStr);
          final now = DateTime.now();
          final difference = now.difference(lastUpdate);

          storeItem.currentDuration = storeItem.currentDuration! - difference;

          ServerManager().updateItem(itemModel: storeItem);
        }
      }
    }

    // Check if any task has an active timer
    final bool hasActiveTimer = TaskProvider().taskList.any((task) => task.isTimerActive == true) || StoreProvider().storeItemList.any((item) => item.isTimerActive == true);

    if (hasActiveTimer) {
      startStopGlobalTimer();
    }
  }
}
