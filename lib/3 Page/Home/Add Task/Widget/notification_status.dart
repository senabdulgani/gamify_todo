import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/5%20Service/notification_services.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:provider/provider.dart';

class NotificationStatus extends StatefulWidget {
  const NotificationStatus({
    super.key,
  });

  @override
  State<NotificationStatus> createState() => _NotificationStatusState();
}

class _NotificationStatusState extends State<NotificationStatus> {
  late final addTaskProvider = context.watch<AddTaskProvider>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.panelBackground,
        borderRadius: AppColors.borderRadiusAll,
      ),
      child: InkWell(
        borderRadius: AppColors.borderRadiusAll,
        onTap: () async {
          await changeNotificationStatus();
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 5),
              Icon(
                addTaskProvider.isNotificationOn
                    ? Icons.notifications_active
                    : addTaskProvider.isAlarmOn
                        ? Icons.alarm
                        : Icons.notifications_off,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future changeNotificationStatus() async {
    if (addTaskProvider.selectedTime == null) {
      final TimeOfDay? selectedTime = await Helper().selectTime(context);

      if (selectedTime != null) {
        if (addTaskProvider.editTask != null) {
          if (!(await NotificationService().requestNotificationPermissions())) return;

          addTaskProvider.updateTime(selectedTime);
          TaskProvider().checkNotification(addTaskProvider.editTask!);
          addTaskProvider.isNotificationOn = true;
        } else {
          addTaskProvider.updateTime(selectedTime);
          addTaskProvider.isNotificationOn = true;
        }
      }

      setState(() {});
    } else {
      if (addTaskProvider.isNotificationOn) {
        if (!(await NotificationService().requestAlarmPermission())) return;

        if (addTaskProvider.editTask != null) {
          NotificationService().cancelNotificationOrAlarm(addTaskProvider.editTask!.id);
          TaskProvider().checkNotification(addTaskProvider.editTask!);
        }

        addTaskProvider.isNotificationOn = false;
        addTaskProvider.isAlarmOn = true;
      } else if (addTaskProvider.isAlarmOn) {
        if (addTaskProvider.editTask != null) {
          NotificationService().cancelNotificationOrAlarm(addTaskProvider.editTask!.id);
        }
        addTaskProvider.isAlarmOn = false;
      } else {
        if (!(await NotificationService().requestNotificationPermissions())) return;

        if (addTaskProvider.editTask != null) {
          TaskProvider().checkNotification(addTaskProvider.editTask!);
        }
        addTaskProvider.isNotificationOn = true;
      }
      setState(() {});
    }
  }
}
