import 'package:flutter/material.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:provider/provider.dart';

class TaskName extends StatelessWidget {
  const TaskName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late final addTaskProvider = context.read<AddTaskProvider>();

    return Center(
      child: SizedBox(
        width: 350,
        child: TextField(
          controller: addTaskProvider.taskNameController,
          decoration: const InputDecoration(
            hintText: 'Task Name',
          ),
          maxLength: 100,
        ),
      ),
    );
  }
}
