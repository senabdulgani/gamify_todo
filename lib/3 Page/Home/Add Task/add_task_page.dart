import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/duraiton_picker.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/notification_switch.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_date.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_days.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_task_type.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_time.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_trait.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/task_name.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:gamify_todo/7%20Enum/trait_type_enum.dart';
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
      create: (_) => AddTaskProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Task"),
          leading: InkWell(
            borderRadius: AppColors.borderRadiusAll,
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
          actions: [
            Consumer(
              builder: (context, AddTaskProvider addTaskProvider, child) {
                return InkWell(
                  borderRadius: AppColors.borderRadiusAll,
                  onTap: () {
                    debugPrint("""
                    name        :   ${addTaskProvider.taskNameController.text}
                    date        :   ${addTaskProvider.selectedDate}
                    time        :   ${addTaskProvider.selectedTime}
                    notificaiton:   ${addTaskProvider.isNotificationOn}
                    duration    :   ${addTaskProvider.duration}
                    type        :   ${addTaskProvider.selectedTaskType}
                    days        :   ${addTaskProvider.selectedDays}
                    skills      :   ${addTaskProvider.selectedTraits.where((trait) => trait.type == TraitTypeEnum.SKILL).map((trait) => trait.title).toList()}
                    attirbutes  :   ${addTaskProvider.selectedTraits.where((trait) => trait.type == TraitTypeEnum.ATTIRBUTE).map((trait) => trait.title).toList()}

                    """);
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.check),
                  ),
                );
              },
            ),
          ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DurationPickerWidget(),
                SizedBox(width: 20),
                SelectTaskType(),
              ],
            ),
            SelectDays(),
            SizedBox(height: 20),
            SelectTrait(isSkill: true),
            SizedBox(height: 10),
            SelectTrait(isSkill: false),
          ],
        ),
      ),
    );
  }
}
