import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/Enums/status_enum.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/2%20General/accessible.dart';
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
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/7%20Enum/trait_type_enum.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late final addTaskProvider = context.read<AddTaskProvider>();
  late final taskProvider = context.read<TaskProvider>();

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
                    if (addTaskProvider.taskNameController.text.trim().isEmpty) {
                      addTaskProvider.taskNameController.clear();

                      Helper().getMessage(
                        message: "Task name cant be empty",
                        status: StatusEnum.WARNING,
                      );
                      return;
                    }

                    if (addTaskProvider.selectedDays.isEmpty) {
                      taskProvider.addTask(
                        TaskModel(
                          id: taskProvider.taskList.length,
                          title: addTaskProvider.taskNameController.text,
                          type: addTaskProvider.selectedTaskType,
                          taskDate: addTaskProvider.selectedDate,
                          time: addTaskProvider.selectedTime,
                          isNotificationOn: addTaskProvider.isNotificationOn,
                          currentDuration: addTaskProvider.selectedTaskType == TaskTypeEnum.TIMER ? Duration.zero : null,
                          remainingDuration: addTaskProvider.taskDuration,
                          currentCount: addTaskProvider.selectedTaskType == TaskTypeEnum.COUNTER ? 0 : null,
                          targetCount: addTaskProvider.targetCount,
                          isTimerActive: addTaskProvider.selectedTaskType == TaskTypeEnum.TIMER ? false : null,
                          attirbuteIDList: addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.ATTIRBUTE).map((e) => e.id).toList(),
                          skillIDList: addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.SKILL).map((e) => e.id).toList(),
                          isCompleted: false,
                        ),
                      );
                    } else {
                      addTaskProvider.addRutin();

                      if (Helper().isSameDay(addTaskProvider.selectedDate, DateTime.now())) {
                        taskProvider.addTask(
                          TaskModel(
                            id: taskProvider.taskList.length,
                            rutinID: rutinList.length,
                            title: addTaskProvider.taskNameController.text,
                            type: addTaskProvider.selectedTaskType,
                            taskDate: addTaskProvider.selectedDate,
                            time: addTaskProvider.selectedTime,
                            isNotificationOn: addTaskProvider.isNotificationOn,
                            currentDuration: addTaskProvider.selectedTaskType == TaskTypeEnum.TIMER ? Duration.zero : null,
                            remainingDuration: addTaskProvider.taskDuration,
                            currentCount: addTaskProvider.selectedTaskType == TaskTypeEnum.COUNTER ? 0 : null,
                            targetCount: addTaskProvider.targetCount,
                            attirbuteIDList: addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.ATTIRBUTE).map((e) => e.id).toList(),
                            skillIDList: addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.SKILL).map((e) => e.id).toList(),
                            isCompleted: false,
                          ),
                        );
                      }
                    }

                    debugPrint("""
                    *************************************************************
                    isRutin: ${addTaskProvider.selectedDays.isNotEmpty}
                    id: ${taskProvider.taskList.length}
                    rutinID: ${rutinList.length}
                    title: ${addTaskProvider.taskNameController.text}
                    type: ${addTaskProvider.selectedTaskType}
                    taskDate: ${addTaskProvider.selectedDate}
                    time: ${addTaskProvider.selectedTime}
                    isNotificationOn: ${addTaskProvider.isNotificationOn}
                    currentDuration: ${addTaskProvider.selectedTaskType == TaskTypeEnum.TIMER ? Duration.zero : null}
                    remainingDuration: ${addTaskProvider.taskDuration}
                    currentCount: ${addTaskProvider.selectedTaskType == TaskTypeEnum.COUNTER ? 0 : null}
                    targetCount: ${addTaskProvider.targetCount}
                    attirbuteIDList: ${addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.ATTIRBUTE).map((e) => e.id).toList()}
                    skillIDList: ${addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.SKILL).map((e) => e.id).toList()}
                    isCompleted: false
                    *************************************************************
                    """);

                    Get.back();
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
        body: const SingleChildScrollView(
          child: Column(
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
              SelectTrait(isSkill: false),
              SizedBox(height: 10),
              SelectTrait(isSkill: true),
            ],
          ),
        ),
      ),
    );
  }
}
