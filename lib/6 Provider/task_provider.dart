import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/7%20Enum/task_status_enum.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';

class TaskProvider with ChangeNotifier {
  // burayı singelton yaptım gayet de iyi oldu neden normalde de context den kullanıyoruz anlamadım. galiba "watch" için olabilir. sibelton kısmını global timer için yaptım.
  static final TaskProvider _instance = TaskProvider._internal();

  factory TaskProvider() {
    return _instance;
  }

  TaskProvider._internal();

  List<TaskModel> taskList = [
    TaskModel(
      id: 0,
      rutinID: 0,
      title: "Python",
      type: TaskTypeEnum.TIMER,
      taskDate: DateTime.now(),
      isNotificationOn: false,
      currentDuration: const Duration(hours: 7, minutes: 10),
      remainingDuration: const Duration(hours: 1, minutes: 0),
      attirbuteIDList: [0],
      skillIDList: [4],
      status: TaskStatusEnum.COMPLETED,
      isTimerActive: false,
    ),
    TaskModel(
      id: 1,
      title: "makale",
      type: TaskTypeEnum.COUNTER,
      taskDate: DateTime.now(),
      isNotificationOn: false,
      remainingDuration: const Duration(hours: 0, minutes: 15),
      targetCount: 50,
      currentCount: 20,
      attirbuteIDList: [0],
      skillIDList: [5],
      status: TaskStatusEnum.FAILED,
      isTimerActive: false,
    ),
    TaskModel(
      id: 2,
      title: "next level",
      type: TaskTypeEnum.TIMER,
      taskDate: DateTime.now().subtract(const Duration(days: 1)),
      isNotificationOn: false,
      remainingDuration: const Duration(hours: 6, minutes: 0),
      currentDuration: const Duration(hours: 14, minutes: 49),
      attirbuteIDList: [0],
      skillIDList: [3],
      status: TaskStatusEnum.FAILED,
      isTimerActive: false,
    ),
    TaskModel(
      id: 3,
      title: "next level",
      type: TaskTypeEnum.TIMER,
      taskDate: DateTime.now(),
      isNotificationOn: false,
      remainingDuration: const Duration(hours: 6, minutes: 0),
      currentDuration: const Duration(hours: 14, minutes: 49),
      attirbuteIDList: [0],
      skillIDList: [3],
      status: TaskStatusEnum.COMPLETED,
      isTimerActive: false,
    ),
    TaskModel(
      id: 4,
      title: "çöp at",
      type: TaskTypeEnum.CHECKBOX,
      taskDate: DateTime.now(),
      isNotificationOn: false,
    ),
    TaskModel(
      id: 5,
      title: "Uyu",
      type: TaskTypeEnum.CHECKBOX,
      remainingDuration: const Duration(hours: 20, minutes: 0),
      status: TaskStatusEnum.COMPLETED,
      taskDate: DateTime.now(),
      attirbuteIDList: [1],
      isNotificationOn: false,
    ),
    TaskModel(
      id: 6,
      title: "Spor",
      type: TaskTypeEnum.CHECKBOX,
      remainingDuration: const Duration(hours: 7),
      status: TaskStatusEnum.COMPLETED,
      taskDate: DateTime.now(),
      attirbuteIDList: [1, 2],
      isNotificationOn: false,
    ),

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
    TaskModel(
      id: 4,
      title: "Koşuya çık",
      type: TaskTypeEnum.CHECKBOX,
      taskDate: DateTime.now().add(const Duration(days: 2)),
      isNotificationOn: false,
      isTimerActive: false,
    ),
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

  void addTask(TaskModel taskModel) {
    taskList.add(taskModel);

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
    final selectedDate = await Helper().selectDate(context);

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
    taskList.remove(taskModel);

    // TODO: !!!!!!!!!!!!!! şuan direkt listeden sildim ama normalde task listten silinmeyece kgaliba statusu cancel failed veya complete olarak değişecek. loho larak hep tutulacak
    // TODO: iptalde veya silem durumunda geri almak için mesaj çıkacak bir süre
    notifyListeners();
  }

  failedTask(TaskModel taskModel) {
    taskList.remove(taskModel);

    // TODO: !!!!!!!!!!!!!! şuan direkt listeden sildim ama normalde task listten silinmeyece kgaliba statusu cancel failed veya complete olarak değişecek. loho larak hep tutulacak
    // TODO: iptalde veya silem durumunda geri almak için mesaj çıkacak bir süre
    notifyListeners();
  }

  void changeShowCompleted() {
    showCompleted = !showCompleted;

    notifyListeners();
  }
}
