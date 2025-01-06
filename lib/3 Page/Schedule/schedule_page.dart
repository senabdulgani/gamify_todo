import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/extensions.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/add_task_page.dart';
import 'package:gamify_todo/3%20Page/Task%20Detail%20Page/routine_detail_page.dart';
import 'package:gamify_todo/5%20Service/navigator_service.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Program'),
        leading: const BackButton(),
      ),
      body: const WeeklyScheduleView(),
    );
  }
}

class WeeklyScheduleView extends StatelessWidget {
  const WeeklyScheduleView({super.key});

  String _getDurationText(dynamic item) {
    if (item.remainingDuration == null) return 'Belirtilmemiş';

    if (item.type == TaskTypeEnum.COUNTER && item.targetCount != null) {
      // For counter type, multiply remaining duration by target count
      final Duration totalDuration = item.type == TaskTypeEnum.COUNTER ? (item.remainingDuration! * item.targetCount) : item.remainingDuration!;
      return totalDuration.textShort2hour();
    }

    final Duration remainingDuration = item.remainingDuration!;

    return remainingDuration.textShort2hour();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final routines = taskProvider.routineList;
    final tasks = taskProvider.taskList.where((task) => task.routineID == null).toList(); // Filter out routine tasks
    final weekDays = ['Pazartesi', 'Salı', 'Çarşamba', 'Perşembe', 'Cuma', 'Cumartesi', 'Pazar'];

    return ListView.builder(
      itemCount: weekDays.length,
      itemBuilder: (context, index) {
        // Get routines for this day
        final dayRoutines = routines.where((routine) => routine.repeatDays.contains(index + 1)).toList();

        // Get tasks for this day
        final dayTasks = tasks.where((task) {
          final taskWeekday = task.taskDate.weekday;
          return taskWeekday == (index + 1);
        }).toList();

        // Skip if no tasks or routines for this day
        if (dayRoutines.isEmpty && dayTasks.isEmpty) {
          return const SizedBox.shrink();
        }

        return Card(
          margin: const EdgeInsets.all(8),
          child: ExpansionTile(
            title: Text(
              weekDays[index],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              // Show routines
              if (dayRoutines.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Rutinler',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                ...dayRoutines.map((routine) => ListTile(
                      leading: const Icon(Icons.repeat, color: Colors.blue),
                      title: Text(routine.title),
                      subtitle: Text(
                        'Hedef: ${_getDurationText(routine)}',
                        style: TextStyle(color: AppColors.text.withOpacity(0.7)),
                      ),
                      trailing: routine.time != null ? Text('${routine.time!.hour}:${routine.time!.minute.toString().padLeft(2, '0')}') : null,
                      onTap: () async {
                        // Find a task with this routine ID to show routine details
                        final routineTask = taskProvider.taskList.firstWhere(
                          (task) => task.routineID == routine.id,
                          orElse: () => TaskModel(
                            title: routine.title,
                            type: routine.type,
                            taskDate: DateTime.now(),
                            isNotificationOn: routine.isNotificationOn,
                            routineID: routine.id,
                          ),
                        );

                        await NavigatorService().goTo(
                          RoutineDetailPage(taskModel: routineTask),
                          transition: Transition.rightToLeft,
                        );
                      },
                      onLongPress: () async {
                        // Find a task with this routine ID to show routine details
                        final routineTask = taskProvider.taskList.firstWhere(
                          (task) => task.routineID == routine.id,
                          orElse: () => TaskModel(
                            title: routine.title,
                            type: routine.type,
                            taskDate: DateTime.now(),
                            isNotificationOn: routine.isNotificationOn,
                            routineID: routine.id,
                          ),
                        );

                        await NavigatorService().goTo(
                          RoutineDetailPage(taskModel: routineTask),
                          transition: Transition.rightToLeft,
                        );
                      },
                    )),
              ],

              // Show tasks
              if (dayTasks.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Görevler',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
                ...dayTasks.map((task) => ListTile(
                      leading: const Icon(Icons.task_alt, color: Colors.green),
                      title: Text(task.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (task.description?.isNotEmpty ?? false) Text(task.description!),
                          Text(
                            'Hedef: ${_getDurationText(task)}',
                            style: TextStyle(color: AppColors.text.withOpacity(0.7)),
                          ),
                        ],
                      ),
                      trailing: task.time != null ? Text('${task.time!.hour}:${task.time!.minute.toString().padLeft(2, '0')}') : null,
                      onTap: () async {
                        await NavigatorService().goTo(
                          AddTaskPage(editTask: task),
                          transition: Transition.rightToLeft,
                        );
                      },
                    )),
              ],
            ],
          ),
        );
      },
    );
  }
}
