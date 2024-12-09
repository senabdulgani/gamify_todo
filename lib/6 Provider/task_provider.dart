import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/2%20General/accessible.dart';
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

  List<TaskModel> taskList = [
    // TaskModel(
    //   id: 0,
    //   rutinID: 0,
    //   title: "Python",
    //   type: TaskTypeEnum.TIMER,
    //   taskDate: DateTime.now(),
    //   isNotificationOn: false,
    //   currentDuration: const Duration(hours: 7, minutes: 10),
    //   remainingDuration: const Duration(hours: 5, minutes: 0),
    //   attirbuteIDList: [0],
    //   skillIDList: [4],
    //   status: TaskStatusEnum.COMPLETED,
    //   isTimerActive: false,
    // ),
    // TaskModel(
    //   id: 3,
    //   rutinID: 0,
    //   title: "Python",
    //   type: TaskTypeEnum.TIMER,
    //   taskDate: DateTime.now().subtract(const Duration(days: 1)),
    //   isNotificationOn: false,
    //   currentDuration: const Duration(hours: 3, minutes: 30),
    //   remainingDuration: const Duration(hours: 5, minutes: 0),
    //   attirbuteIDList: [0],
    //   skillIDList: [4],
    //   status: null,
    //   isTimerActive: false,
    // ),
    // TaskModel(
    //   id: 1,
    //   title: "makale",
    //   type: TaskTypeEnum.COUNTER,
    //   taskDate: DateTime.now(),
    //   isNotificationOn: false,
    //   remainingDuration: const Duration(hours: 0, minutes: 15),
    //   targetCount: 50,
    //   currentCount: 20,
    //   attirbuteIDList: [0],
    //   skillIDList: [5],
    //   status: TaskStatusEnum.FAILED,
    //   isTimerActive: false,
    // ),
    // TaskModel(
    //   id: 2,
    //   title: "next level",
    //   type: TaskTypeEnum.TIMER,
    //   taskDate: DateTime.now().subtract(const Duration(days: 1)),
    //   isNotificationOn: false,
    //   remainingDuration: const Duration(hours: 6, minutes: 0),
    //   currentDuration: const Duration(hours: 14, minutes: 49),
    //   attirbuteIDList: [0],
    //   skillIDList: [3],
    //   status: TaskStatusEnum.FAILED,
    //   isTimerActive: false,
    // ),
    // TaskModel(
    //   id: 4,
    //   title: "çöp at",
    //   type: TaskTypeEnum.CHECKBOX,
    //   taskDate: DateTime.now(),
    //   isNotificationOn: false,
    // ),
    // TaskModel(
    //   id: 5,
    //   title: "Uyu",
    //   type: TaskTypeEnum.CHECKBOX,
    //   remainingDuration: const Duration(hours: 20, minutes: 0),
    //   status: TaskStatusEnum.COMPLETED,
    //   taskDate: DateTime.now(),
    //   attirbuteIDList: [1],
    //   isNotificationOn: false,
    // ),
    // TaskModel(
    //   id: 6,
    //   title: "Spor",
    //   type: TaskTypeEnum.CHECKBOX,
    //   remainingDuration: const Duration(hours: 7),
    //   status: TaskStatusEnum.COMPLETED,
    //   taskDate: DateTime.now(),
    //   attirbuteIDList: [1, 2],
    //   isNotificationOn: false,
    // ),

    // TaskModel(
    //   id: 2,
    //   rutinID: 1,
    //   title: "Makale oku",
    //   type: TaskTypeEnum.COUNTER,
    //   taskDate: DateTime.now(),
    //   isNotificationOn: false,
    //   currentCount: 3,
    //   targetCount: 10,
    //   remainingDuration: const Duration(minutes: 15),
    //   isCompleted: false,
    // ),
    // TaskModel(
    //   id: 3,
    //   title: "Mediate",
    //   type: TaskTypeEnum.TIMER,
    //   taskDate: DateTime.now(),
    //   isNotificationOn: false,
    //   currentDuration: const Duration(hours: 0, minutes: 0),
    //   remainingDuration: const Duration(minutes: 15),
    //   attirbuteIDList: [1, 2],
    //   skillIDList: [1],
    //   isCompleted: false,
    //   isTimerActive: false,
    // ),
    // TaskModel(
    //   id: 7,
    //   title: "Koşuya çık",
    //   type: TaskTypeEnum.CHECKBOX,
    //   taskDate: DateTime.now().add(const Duration(days: 2)),
    //   isNotificationOn: false,
    //   isTimerActive: false,
    // ),
    // TaskModel(
    //   id: 4,
    //   title: "Kelime Ezberle",
    //   type: TaskTypeEnum.COUNTER,
    //   targetCount: 20,
    //   currentCount: 0,
    //   taskDate: DateTime.now().add(const Duration(days: 2)),
    //   isNotificationOn: false,
    //   isCompleted: false,
    //   isTimerActive: false,
    // ),
    // TaskModel(
    //   id: 4,
    //   title: "Kelime Ezberle",
    //   type: TaskTypeEnum.COUNTER,
    //   targetCount: 20,
    //   currentCount: 0,
    //   taskDate: DateTime.now().add(const Duration(days: 3)),
    //   isNotificationOn: false,
    //   isCompleted: false,
    //   isTimerActive: false,
    // ),
  ];

  // TODO: saat 00:00:00 geçtikten sonra hala dünü gösterecek muhtemelen her ana sayfaya gidişte. bunu düzelt. yani değişken uygulama açıldığında belirlendiği için 12 den sonra değişmeyecek.
  DateTime selectedDate = DateTime.now();
  bool showCompleted = true;

  void addTask(TaskModel taskModel) async {
    await ServerManager().addTask(taskModel: taskModel);

    taskList.add(taskModel);

    notifyListeners();
  }

  void editTask({
    required TaskModel taskModel,
    required List<int> selectedDays,
  }) {
    if (taskModel.routineID != null) {
      RoutineModel routine = routineList[taskModel.routineID!];

      routine.title = taskModel.title;
      routine.type = taskModel.type;
      routine.startDate = taskModel.taskDate;
      routine.time = taskModel.time;
      routine.isNotificationOn = taskModel.isNotificationOn;
      routine.remainingDuration = taskModel.remainingDuration;
      routine.targetCount = taskModel.targetCount;
      routine.repeatDays = selectedDays;
      routine.attirbuteIDList = taskModel.attirbuteIDList;
      routine.skillIDList = taskModel.skillIDList;
      routine.isCompleted = taskModel.status == TaskStatusEnum.COMPLETED ? true : false;

      // rutinin ismi değişmişse o rutine ait taskalrın ismi de değişsin
      // eğer ilgili traitler değişmişse o rutine ait taskalrın traitleri de değişsin
      for (var task in taskList) {
        if (task.routineID == taskModel.routineID) {
          task.title = taskModel.title;
          task.attirbuteIDList = taskModel.attirbuteIDList;
          task.skillIDList = taskModel.skillIDList;
        }
      }
    } else {
      final index = taskList.indexWhere((element) => element.id == taskModel.id);
      taskList[index] = taskModel;
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

    // TODO: iptalde veya silem durumunda geri almak için mesaj çıkacak bir süre
    notifyListeners();
  }

  failedTask(TaskModel taskModel) {
    taskModel.status = TaskStatusEnum.FAILED;

    // TODO: iptalde veya silem durumunda geri almak için mesaj çıkacak bir süre
    notifyListeners();
  }

  // TODO: delete
  deleteTask(TaskModel taskModel) {
    taskList.remove(taskModel);

    // TODO: iptalde veya silem durumunda geri almak için mesaj çıkacak bir süre
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
