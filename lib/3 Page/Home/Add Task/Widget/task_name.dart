import 'package:flutter/material.dart';
import 'package:gamify_todo/6%20Provider/add_store_item_providerr.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:provider/provider.dart';

class TaskName extends StatelessWidget {
  const TaskName({
    super.key,
    this.isStore = false,
  });

  final bool isStore;

  @override
  Widget build(BuildContext context) {
    late final dynamic provider = isStore ? context.read<AddStoreItemProvider>() : context.read<AddTaskProvider>();

    return Center(
      child: SizedBox(
        width: 350,
        child: TextField(
          controller: provider.taskNameController,
          decoration: const InputDecoration(
            hintText: 'Task Name',
          ),
          maxLength: 100,
        ),
      ),
    );
  }
}
