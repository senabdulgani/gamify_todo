import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/3%20Page/Home/Widget/task_item.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<TaskModel> selectedDateTaskList = [];

  @override
  Widget build(BuildContext context) {
    context.watch<TaskProvider>();

    // !!!!!!!!!!!!! TODO:: AAAAAAAAAAAAAA bu fonskiyonun çok verimiz olduğunu düşünüyorum. daha iyi bir yol bul
    selectedDateTaskList.clear();
    for (var task in context.read<TaskProvider>().taskList) {
      if (Helper().isSameDay(task.taskDate, context.read<TaskProvider>().selectedDate)) {
        selectedDateTaskList.add(task);
      }
    }

    return ListView.builder(
      itemCount: selectedDateTaskList.length,
      itemBuilder: (context, index) {
        return TaskItem(taskModel: selectedDateTaskList[index]);
      },
    );
  }
}
