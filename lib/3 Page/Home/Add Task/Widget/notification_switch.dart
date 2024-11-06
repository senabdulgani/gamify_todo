import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/Enums/status_enum.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:provider/provider.dart';

class NotificationSwitch extends StatefulWidget {
  const NotificationSwitch({super.key});

  @override
  State<NotificationSwitch> createState() => _NotificationSwitchState();
}

class _NotificationSwitchState extends State<NotificationSwitch> {
  late final addTaskProvider = context.watch<AddTaskProvider>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppColors.borderRadiusAll,
      onTap: () {
        changeNotificationStatus();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 5),
          const Icon(
            Icons.notifications,
            size: 30,
          ),
          Switch(
            value: addTaskProvider.isNotificationOn,
            onChanged: (isNotificationOn) {
              changeNotificationStatus();
            },
          ),
        ],
      ),
    );
  }

  changeNotificationStatus() {
    if (addTaskProvider.selectedTime == null || addTaskProvider.selectedDate == null) {
      Helper().getMessage(
        status: StatusEnum.WARNING,
        message: "You must select date and time",
      );
    } else {
      addTaskProvider.isNotificationOn = !addTaskProvider.isNotificationOn;
      setState(() {});
    }
  }
}
