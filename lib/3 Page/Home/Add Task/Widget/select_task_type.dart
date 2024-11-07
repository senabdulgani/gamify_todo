import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_target_count.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:provider/provider.dart';

class SelectTaskType extends StatefulWidget {
  const SelectTaskType({super.key});

  @override
  State<SelectTaskType> createState() => _SelectTaskTypeState();
}

class _SelectTaskTypeState extends State<SelectTaskType> {
  late final addTaskProvider = context.read<AddTaskProvider>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            taskTypeButton(TaskTypeEnum.CHECKBOX),
            taskTypeButton(TaskTypeEnum.COUNTER),
            taskTypeButton(TaskTypeEnum.TIMER),
          ],
        ),
        if (addTaskProvider.selectedTaskType == TaskTypeEnum.COUNTER) ...[
          const SizedBox(height: 15),
          const SelectTargetCount(),
        ],
      ],
    );
  }

  InkWell taskTypeButton(TaskTypeEnum taskType) {
    return InkWell(
      borderRadius: AppColors.borderRadiusAll,
      onTap: () {
        setState(() {
          addTaskProvider.selectedTaskType = taskType;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppColors.borderRadiusAll,
          color: addTaskProvider.selectedTaskType == taskType ? AppColors.main : Colors.transparent,
        ),
        padding: const EdgeInsets.all(5),
        child: Icon(
          taskType == TaskTypeEnum.CHECKBOX
              ? Icons.check_box
              : taskType == TaskTypeEnum.COUNTER
                  ? Icons.add
                  : Icons.timer,
          size: 30,
        ),
      ),
    );
  }
}
