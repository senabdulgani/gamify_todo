import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Home/Widget/Task%20Item/Widgets/progress_text.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';

class TitleAndDescription extends StatelessWidget {
  const TitleAndDescription({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    final priorityColor = (taskModel.priority == 1
            ? AppColors.red
            : taskModel.priority == 2
                ? AppColors.orange2
                : AppColors.text)
        .withValues(alpha: 0.9);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AutoSizeText(
            taskModel.title,
            maxLines: 1,
            minFontSize: 14,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: priorityColor,
            ),
          ),
          if (taskModel.description != null && taskModel.description!.isNotEmpty)
            Text(
              taskModel.description!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: priorityColor.withValues(alpha: 0.7),
              ),
            ),
          ProgressText(taskModel: taskModel),
        ],
      ),
    );
  }
}
