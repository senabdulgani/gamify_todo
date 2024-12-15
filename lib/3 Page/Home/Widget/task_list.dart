import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/3%20Page/Home/Widget/task_item.dart';
import 'package:gamify_todo/5%20Service/locale_keys.g.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<TaskModel> selectedDateTaskList = [];
  List<TaskModel> selectedDateRutinTaskList = [];
  List<TaskModel> selectedDateGhostRutinTaskList = [];

  @override
  Widget build(BuildContext context) {
    context.watch<TaskProvider>();
    context.watch<AddTaskProvider>();

    // !!!!!!!!!!!!! TODO:: AAAAAAAAAAAAAA bu fonskiyonun ve bu sayfanın çok verimiz olduğunu düşünüyorum. daha iyi bir yol bul
    selectedDateTaskList.clear();
    selectedDateRutinTaskList.clear();
    selectedDateGhostRutinTaskList.clear();

    for (var task in context.read<TaskProvider>().taskList) {
      if (Helper().isSameDay(task.taskDate, context.read<TaskProvider>().selectedDate)) {
        if ((!context.read<TaskProvider>().showCompleted && task.status != null) && !(task.type == TaskTypeEnum.TIMER && task.isTimerActive == true)) {
          continue;
        } else {
          if (task.routineID == null) {
            selectedDateTaskList.add(task);
          } else {
            selectedDateRutinTaskList.add(task);
          }
        }
      }
    }

    if (!Helper().isBeforeOrSameDay(context.read<TaskProvider>().selectedDate, DateTime.now())) {
      for (var rutin in context.read<TaskProvider>().routineList) {
        if (rutin.repeatDays.contains(context.read<TaskProvider>().selectedDate.weekday - 1) && Helper().isBeforeOrSameDay(rutin.startDate, context.read<TaskProvider>().selectedDate)) {
          if (!rutin.isCompleted) {
            selectedDateGhostRutinTaskList.add(
              TaskModel(
                routineID: rutin.id,
                title: rutin.title,
                type: rutin.type,
                taskDate: context.read<TaskProvider>().selectedDate,
                time: rutin.time,
                isNotificationOn: rutin.isNotificationOn,
                currentDuration: rutin.type == TaskTypeEnum.TIMER ? Duration.zero : null,
                remainingDuration: rutin.remainingDuration,
                currentCount: rutin.type == TaskTypeEnum.COUNTER ? 0 : null,
                targetCount: rutin.targetCount,
                isTimerActive: rutin.type == TaskTypeEnum.TIMER ? false : null,
                attributeIDList: rutin.attirbuteIDList,
                skillIDList: rutin.skillIDList,
              ),
            );
          }
        }
      }
    }

    return selectedDateTaskList.isEmpty && selectedDateGhostRutinTaskList.isEmpty && selectedDateRutinTaskList.isEmpty
        ? Center(
            child: Text(
              LocaleKeys.NoTaskForToday.tr(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                // Normal tasks
                ...List.generate(
                  selectedDateTaskList.length,
                  (index) => TaskItem(taskModel: selectedDateTaskList[index]),
                ),

                // Routine Tasks
                if (selectedDateRutinTaskList.isNotEmpty) const SizedBox(height: 20),
                if (selectedDateRutinTaskList.isNotEmpty)
                  Text(
                    LocaleKeys.Routines.tr(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ...List.generate(
                  selectedDateRutinTaskList.length,
                  (index) => TaskItem(
                    taskModel: selectedDateRutinTaskList[index],
                  ),
                ),

                // future routines ghosts
                if (selectedDateTaskList.isEmpty) const SizedBox(height: 20),
                if (selectedDateGhostRutinTaskList.isNotEmpty)
                  Text(
                    LocaleKeys.FutureRoutines.tr(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ...List.generate(
                  selectedDateGhostRutinTaskList.length,
                  (index) => TaskItem(
                    taskModel: selectedDateGhostRutinTaskList[index],
                  ),
                ),
              ],
            ),
          );
  }
}
