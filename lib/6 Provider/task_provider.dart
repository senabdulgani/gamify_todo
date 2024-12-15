import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/5%20Service/server_manager.dart';
import 'package:gamify_todo/7%20Enum/task_status_enum.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/rutin_model.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';

class TaskProvider with ChangeNotifier {
  // burayı singelton yaptım gayet de iyi oldu neden normalde de context den kullanıyoruz anlamadım. galiba "watch" için olabilir. sibelton kısmını global timer için yaptım.
  static final TaskProvider _instance = TaskProvider._internal();

  factory TaskProvider() {
    return _instance;
  }

  TaskProvider._internal();

  List<RoutineModel> routineList = [];

  List<TaskModel> taskList = [];

  // TODO: saat 00:00:00 geçtikten sonra hala dünü gösterecek muhtemelen her ana sayfaya gidişte. bunu düzelt. yani değişken uygulama açıldığında belirlendiği için 12 den sonra değişmeyecek.
  DateTime selectedDate = DateTime.now();
  bool showCompleted = true;

  void addTask(TaskModel taskModel) async {
    final int taskId = await ServerManager().addTask(taskModel: taskModel);

    taskModel.id = taskId;

    taskList.add(taskModel);

    notifyListeners();
  }

  Future addRoutine(RoutineModel routineModel) async {
    final int routineId = await ServerManager().addRoutine(routineModel: routineModel);

    routineModel.id = routineId;

    routineList.add(routineModel);
  }

  void editTask({
    required TaskModel taskModel,
    required List<int> selectedDays,
  }) {
    if (taskModel.routineID != null) {
      RoutineModel routine = routineList.where((element) => element.id == taskModel.routineID).first;

      routine.title = taskModel.title;
      routine.type = taskModel.type;
      routine.startDate = taskModel.taskDate;
      routine.time = taskModel.time;
      routine.isNotificationOn = taskModel.isNotificationOn;
      routine.remainingDuration = taskModel.remainingDuration;
      routine.targetCount = taskModel.targetCount;
      routine.repeatDays = selectedDays;
      routine.attirbuteIDList = taskModel.attributeIDList;
      routine.skillIDList = taskModel.skillIDList;
      routine.isCompleted = taskModel.status == TaskStatusEnum.COMPLETED ? true : false;

      ServerManager().updateRoutine(routineModel: routine);

      for (var task in taskList) {
        if (task.routineID == taskModel.routineID) {
          task.title = taskModel.title;
          task.attributeIDList = taskModel.attributeIDList;
          task.skillIDList = taskModel.skillIDList;

          //TODO: tek tek güncelleme istekleri yapmak yerine bir kerede güncelleme yapmak daha mantıklı
          ServerManager().updateTask(taskModel: task);
        }
      }
    } else {
      final index = taskList.indexWhere((element) => element.id == taskModel.id);
      taskList[index] = taskModel;

      ServerManager().updateTask(taskModel: taskModel);
    }

    notifyListeners();
  }

  void updateItems() {
    notifyListeners();
  }

  void changeSelectedDate(DateTime selectedDateZ) {
    selectedDate = selectedDateZ;

    notifyListeners();
  }

  Future<void> changeTaskDate({
    required BuildContext context,
    required TaskModel taskModel,
  }) async {
    final selectedDate = await Helper().selectDate(
      context: context,
      initialDate: taskModel.taskDate,
    );

    if (selectedDate != null) {
      if (taskModel.type == TaskTypeEnum.TIMER && taskModel.isTimerActive == true) {
        taskModel.isTimerActive = false;
      }
      taskModel.taskDate = selectedDate;
    }

    notifyListeners();
  }

  // iptal de kullanıcıya ceza yansıtılmayacak
  cancelTask(TaskModel taskModel) {
    taskModel.status = TaskStatusEnum.CANCEL;

    ServerManager().updateTask(taskModel: taskModel);

    // TODO: iptalde veya silem durumunda geri almak için mesaj çıkacak bir süre
    notifyListeners();
  }

  failedTask(TaskModel taskModel) {
    taskModel.status = TaskStatusEnum.FAILED;

    ServerManager().updateTask(taskModel: taskModel);

    // TODO: iptalde veya silem durumunda geri almak için mesaj çıkacak bir süre
    notifyListeners();
  }

  // TODO: delete
  deleteTask(TaskModel taskModel) {
    taskList.remove(taskModel);

    ServerManager().deleteTask(id: taskModel.id);

    // TODO: iptalde veya silem durumunda geri almak için mesaj çıkacak bir süre
    notifyListeners();
  }

  // Delete routine
  deleteRoutine(int routineID) {
    final routineModel = routineList.where((element) => element.id == routineID).first;

    routineList.remove(routineModel);
    ServerManager().deleteRoutine(id: routineModel.id);

    notifyListeners();
  }

  // TODO: just for routine
  // ? rutin model mi task model mi
  completeRoutine(TaskModel taskModel) {
    taskModel.status = TaskStatusEnum.COMPLETED;

    // TODO: iptalde veya silem durumunda geri almak için mesaj çıkacak bir süre
    // TODO: arşivden çıkar ekle
    notifyListeners();
  }

  void changeShowCompleted() {
    showCompleted = !showCompleted;

    notifyListeners();
  }
}
