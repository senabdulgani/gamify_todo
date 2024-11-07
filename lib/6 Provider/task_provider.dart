import 'package:flutter/material.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> taskList = [
    TaskModel(
        id: 0,
        rutinID: 0,
        title: "Python",
        type: TaskTypeEnum.TIMER,
        taskDate: DateTime.now(),
        isNotificationOn: false,
        currentDuration: const Duration(hours: 0, minutes: 0),
        remainingDuration: const Duration(hours: 1, minutes: 0),
        targetCount: 0,
        attirbuteIDList: [1, 2],
        skillIDList: [1],
        isCompleted: false,
        isTimerActive: false),
    TaskModel(
      id: 1,
      title: "çöp at",
      type: TaskTypeEnum.CHECKBOX,
      taskDate: DateTime.now(),
      isNotificationOn: false,
      targetCount: 0,
      isCompleted: false,
    ),
    TaskModel(
      id: 2,
      rutinID: 1,
      title: "Makale oku",
      type: TaskTypeEnum.COUNTER,
      taskDate: DateTime.now(),
      isNotificationOn: false,
      currentCount: 0,
      targetCount: 10,
      remainingDuration: const Duration(minutes: 15),
      isCompleted: false,
    ),
  ];

  void addTask(TaskModel taskModel) {
    taskList.add(taskModel);

    notifyListeners();
  }

  // edit task

  // delete task
}
