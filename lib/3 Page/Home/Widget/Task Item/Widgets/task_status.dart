import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/5%20Service/locale_keys.g.dart';
import 'package:gamify_todo/7%20Enum/task_status_enum.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';

class TaskStatus extends StatelessWidget {
  const TaskStatus({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    switch (taskModel.status) {
      case TaskStatusEnum.FAILED:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.red.withAlpha(100),
            borderRadius: AppColors.borderRadiusAll,
          ),
          child: Text(
            LocaleKeys.Failed.tr(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      case TaskStatusEnum.CANCEL:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.purple.withAlpha(100),
            borderRadius: AppColors.borderRadiusAll,
          ),
          child: Text(
            LocaleKeys.Cancel.tr(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      case TaskStatusEnum.COMPLETED:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.green.withAlpha(80),
            borderRadius: AppColors.borderRadiusAll,
          ),
          child: Text(
            LocaleKeys.Completed.tr(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
