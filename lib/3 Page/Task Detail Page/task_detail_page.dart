import 'package:flutter/material.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/add_task_page.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:get/route_manager.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
        leading: const SizedBox(),
        actions: [
          IconButton(
            onPressed: () async {
              // burada niye çalışmıyor. sadece 1 tane mi hakkmızı var awm
              // await NavigatorService().goTo(
              //   AddTaskPage(
              //     editTask: widget.taskModel,
              //   ),
              //   transition: Transition.rightToLeftWithFade,
              // );

              await Get.to(
                () => AddTaskPage(
                  editTask: widget.taskModel,
                ),
                transition: Transition.rightToLeft,
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}
