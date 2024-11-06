import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
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
    return Row(
      children: [
        taskTypeButton(TaskTypeEnum.CHECKBOX),
        taskTypeButton(TaskTypeEnum.COUNTER),
        taskTypeButton(TaskTypeEnum.TIMER),
      ],
    );
  }

  InkWell taskTypeButton(TaskTypeEnum taskType) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      onTap: () {
        setState(() {
          addTaskProvider.selectedTaskType = taskType;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
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
