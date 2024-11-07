import 'package:flutter/material.dart';
import 'package:gamify_todo/3%20Page/Home/Widget/task_item.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: context.watch<TaskProvider>().taskList.length,
      itemBuilder: (context, index) {
        return TaskItem(taskModel: context.watch<TaskProvider>().taskList[index]);
      },
    );
  }
}
