import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/extensions.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/5%20Service/locale_keys.g.dart';
import 'package:gamify_todo/5%20Service/notification_services.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class SelectTime extends StatefulWidget {
  const SelectTime({
    super.key,
  });

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  late final addTaskProvider = context.read<AddTaskProvider>();

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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.watch<AddTaskProvider>().selectedTime?.to12Hours() ?? LocaleKeys.NotSelected.tr(),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        onTap: () async {
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
        },
      ),
    );
  }
}
