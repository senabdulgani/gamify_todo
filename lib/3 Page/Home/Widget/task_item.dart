import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: AppColors.panelBackground2,
        child: Column(
          children: [
            Text("Task id: ${widget.taskModel.id}"),
            Text("Task rutinId: ${widget.taskModel.rutinID}"),
            Text("Task title: ${widget.taskModel.title}"),
            Text("Task type: ${widget.taskModel.type}"),
            Text("Task taskDate: ${widget.taskModel.taskDate}"),
            Text("Task time: ${widget.taskModel.time}"),
            Text("Task isNotificationOn: ${widget.taskModel.isNotificationOn}"),
            Text("Task currentDuration: ${widget.taskModel.currentDuration}"),
            Text("Task remainingDuration: ${widget.taskModel.remainingDuration}"),
            Text("Task currentCount: ${widget.taskModel.currentCount}"),
            Text("Task targetCount: ${widget.taskModel.targetCount}"),
            Text("Task attirbuteIDList: ${widget.taskModel.attirbuteIDList}"),
            Text("Task skillIDList: ${widget.taskModel.skillIDList}"),
            Text("Task isCompleted: ${widget.taskModel.isCompleted}"),
          ],
        ),
      ),
    );
  }
}
