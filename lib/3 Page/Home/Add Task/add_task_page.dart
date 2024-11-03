import 'package:flutter/material.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/duraiton_picker.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/notification_switch.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_date.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_time.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/task_name.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late final addTaskProvider = context.read<AddTaskProvider>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddTaskProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Task"),
          leading: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: const Column(
          children: [
            SizedBox(height: 20),
            TaskName(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectDate(),
                SelectTime(),
                NotificationSwitch(),
              ],
            ),
            DurationPickerWidget(),
          ],
        ),
      ),
    );
  }
}
