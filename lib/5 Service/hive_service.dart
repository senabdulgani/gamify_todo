import 'dart:convert';
import 'dart:io';

import 'package:gamify_todo/1%20Core/extensions.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/7%20Enum/task_status_enum.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:gamify_todo/8%20Model/user_model.dart';
import 'package:gamify_todo/8%20Model/store_item_model.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:gamify_todo/8%20Model/trait_model.dart';
import 'package:gamify_todo/8%20Model/routine_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiveService {
  static const String _userBoxName = 'userBox';
  static const String _itemBoxName = 'itemBox';
  static const String _traitBoxName = 'traitBox';
  static const String _routineBoxName = 'routineBox';
  static const String _taskBoxName = 'taskBox';

  Future<Box<UserModel>> get _userBox async => await Hive.openBox<UserModel>(_userBoxName);
  Future<Box<ItemModel>> get _itemBox async => await Hive.openBox<ItemModel>(_itemBoxName);
  Future<Box<TraitModel>> get _traitBox async => await Hive.openBox<TraitModel>(_traitBoxName);
  Future<Box<RoutineModel>> get _routineBox async => await Hive.openBox<RoutineModel>(_routineBoxName);
  Future<Box<TaskModel>> get _taskBox async => await Hive.openBox<TaskModel>(_taskBoxName);

  // User methods
  Future<void> addUser(UserModel userModel) async {
    final box = await _userBox;
    await box.put(userModel.id, userModel);
  }

  Future<UserModel?> getUser(int id) async {
    final box = await _userBox;
    return box.get(id);
  }

  Future<void> updateUser(UserModel userModel) async {
    final box = await _userBox;
    await box.put(userModel.id, userModel);
  }

  // Item methods
  Future<void> addItem(ItemModel itemModel) async {
    final box = await _itemBox;
    await box.put(itemModel.id, itemModel);
  }

  Future<List<ItemModel>> getItems() async {
    final box = await _itemBox;
    return box.values.toList();
  }

  Future<void> updateItem(ItemModel itemModel) async {
    final box = await _itemBox;
    await box.put(itemModel.id, itemModel);
  }

  Future<void> deleteItem(int id) async {
    final box = await _itemBox;
    await box.delete(id);
  }

  // Trait methods
  Future<void> addTrait(TraitModel traitModel) async {
    final box = await _traitBox;
    await box.put(traitModel.id, traitModel);
  }

  Future<List<TraitModel>> getTraits() async {
    final box = await _traitBox;
    return box.values.toList();
  }

  Future<void> updateTrait(TraitModel traitModel) async {
    final box = await _traitBox;
    await box.put(traitModel.id, traitModel);
  }

  Future<void> deleteTrait(int id) async {
    final box = await _traitBox;
    await box.delete(id);
  }

  // Routine methods
  Future<void> addRoutine(RoutineModel routineModel) async {
    final box = await _routineBox;
    await box.put(routineModel.id, routineModel);
  }

  Future<List<RoutineModel>> getRoutines() async {
    final box = await _routineBox;
    return box.values.toList();
  }

  Future<void> updateRoutine(RoutineModel routineModel) async {
    final box = await _routineBox;
    await box.put(routineModel.id, routineModel);
  }

  Future<void> deleteRoutine(int id) async {
    final box = await _routineBox;
    await box.delete(id);
  }

  // Task methods
  Future<void> addTask(TaskModel taskModel) async {
    final box = await _taskBox;
    await box.put(taskModel.id, taskModel);
  }

  Future<List<TaskModel>> getTasks() async {
    final box = await _taskBox;
    return box.values.toList();
  }

  Future<void> updateTask(TaskModel taskModel) async {
    final box = await _taskBox;
    await box.put(taskModel.id, taskModel);
  }

  Future<void> deleteTask(int id) async {
    final box = await _taskBox;
    await box.delete(id);
  }

  Future<void> createTasksFromRoutines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final DateTime today = DateTime.now();
    final String? lastLoginDateString = prefs.getString('lastLoginDate');
    final DateTime lastLoginDate = lastLoginDateString != null ? DateTime.parse(lastLoginDateString) : today;

    if (TaskProvider().routineList.isNotEmpty) {
      // create new tasks from routines
      int taskID = prefs.getInt("last_task_id") ?? 0;

      for (DateTime date = lastLoginDate.add(const Duration(days: 1)); date.isBeforeOrSameDay(today); date = date.add(const Duration(days: 1))) {
        for (RoutineModel routine in TaskProvider().routineList) {
          if (routine.repeatDays.contains(date.weekday) && routine.startDate.isBeforeOrSameDay(date) && !routine.isCompleted) {
            taskID++;

            final TaskModel task = TaskModel(
              id: taskID,
              title: routine.title,
              description: routine.description,
              taskDate: date,
              status: null,
              type: routine.type,
              isNotificationOn: routine.isNotificationOn,
              isAlarmOn: routine.isAlarmOn,
              priority: routine.priority,
              routineID: routine.id,
              time: routine.time,
              attributeIDList: routine.attirbuteIDList,
              skillIDList: routine.skillIDList,
              currentCount: routine.type == TaskTypeEnum.COUNTER ? 0 : null,
              targetCount: routine.targetCount,
              currentDuration: routine.type == TaskTypeEnum.TIMER ? Duration.zero : null,
              remainingDuration: routine.remainingDuration,
              isTimerActive: routine.type == TaskTypeEnum.TIMER ? false : null,
            );

            TaskProvider().taskList.add(task);
            addTask(task);

            // TODO: schedule notification or alarm
          }
        }
      }
      prefs.setInt("last_task_id", TaskProvider().taskList.last.id);
    }

    if (TaskProvider().taskList.isNotEmpty) {
      // failed all past tasks if status null
      for (TaskModel task in TaskProvider().taskList) {
        if (task.status == null && task.taskDate.isBeforeDay(today)) {
          task.status = TaskStatusEnum.FAILED;

          updateTask(task);
        }
      }
    }

    prefs.setString('lastLoginDate', today.toIso8601String());
  }

  // delete all data
  Future<void> deleteAllData() async {
    final box = await _userBox;
    await box.clear();

    final box2 = await _itemBox;
    await box2.clear();

    final box3 = await _traitBox;
    await box3.clear();

    final box4 = await _routineBox;
    await box4.clear();

    final box5 = await _taskBox;
    await box5.clear();
  }

  // export
  // Future<void> exportData() async {
  //   final List<UserModel> userList = await Hive.openBox<UserModel>(_userBoxName).then((value) => value.values.toList());
  //   final List<ItemModel> itemList = await Hive.openBox<ItemModel>(_itemBoxName).then((value) => value.values.toList());
  //   final List<TraitModel> traitList = await Hive.openBox<TraitModel>(_traitBoxName).then((value) => value.values.toList());
  //   final List<RoutineModel> routineList = await Hive.openBox<RoutineModel>(_routineBoxName).then((value) => value.values.toList());
  //   final List<TaskModel> taskList = await Hive.openBox<TaskModel>(_taskBoxName).then((value) => value.values.toList());

  //   // hepsini json dosyasına kaydet
  // }

  // // import
  // Future<void> importData() async {}

// Future<void> backupHiveBox<T>(String boxName, String backupPath) async {
//   final box = await Hive.openBox<T>(boxName);
//   final boxPath = box.path;
//   await box.close();

//   try {
//     File(boxPath).copy(backupPath);
//   } finally {
//     await Hive.openBox<T>(boxName);
//   }
// }

// Future<void> restoreHiveBox<T>(String boxName, String backupPath) async {
//   final box = await Hive.openBox<T>(boxName);
//   final boxPath = box.path;
//   await box.close();

//   try {
//     File(backupPath).copy(boxPath);
//   } finally {
//     await Hive.openBox<T>(boxName);
//   }
// }

  // Future<void> exportData() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final file = File('${directory.path}/hive_export.json');
  //   final box = await Hive.openBox(_taskBoxName);
  //   final data = box.toMap();
  //   await file.writeAsString(data.toString());
  // }

  // // import
  // Future<void> importData() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final file = File('${directory.path}/hive_export.json');
  //   if (await file.exists()) {
  //     final content = await file.readAsString();
  //     final data = Map<String, dynamic>.from(jsonDecode(content));
  //     final box = await Hive.openBox(_taskBoxName);
  //     await box.putAll(data);
  //   }
  // }

// Future<void> exportData() async {
//   final directory = await getApplicationDocumentsDirectory();
//   final file = File('${directory.path}/hive_export.json');

//   final Map<String, dynamic> data = {};

//   for (String boxName in [_userBoxName, _itemBoxName, _traitBoxName, _routineBoxName, _taskBoxName]) {
//     final box = await Hive.openBox(boxName);
//     data[boxName] = box.toMap();
//   }

//   await file.writeAsString(jsonEncode(data));
// }

// Future<void> importData() async {
//   final directory = await getApplicationDocumentsDirectory();
//   final file = File('${directory.path}/hive_export.json');

//   if (await file.exists()) {
//     final content = await file.readAsString();
//     final Map<String, dynamic> data = jsonDecode(content);

  Future<void> exportData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/hive_export.json');
    final Map<String, dynamic> allData = {};

    final userBox = await _userBox;
    allData[_userBoxName] = userBox.toMap().map((key, value) => MapEntry(key, value.toJson()));

    final itemBox = await _itemBox;
    allData[_itemBoxName] = itemBox.toMap().map((key, value) => MapEntry(key, value.toJson()));

    final traitBox = await _traitBox;
    allData[_traitBoxName] = traitBox.toMap().map((key, value) => MapEntry(key, value.toJson()));

    final routineBox = await _routineBox;
    allData[_routineBoxName] = routineBox.toMap().map((key, value) => MapEntry(key, value.toJson()));

    final taskBox = await _taskBox;
    allData[_taskBoxName] = taskBox.toMap().map((key, value) => MapEntry(key, value.toJson()));

    // yukarıdakiler çıkartılamadan önce ne durumda oluyor bak. aşağıda hata veriyor.
    await file.writeAsString(jsonEncode(allData));
  }

  Future<void> importData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/hive_export.json');
    if (await file.exists()) {
      final content = await file.readAsString();
      final Map<String, dynamic> allData = jsonDecode(content);

      final userBox = await _userBox;
      await userBox.putAll(Map<String, dynamic>.from(allData[_userBoxName]).map((key, value) => MapEntry(key, UserModel.fromJson(value))));

      final itemBox = await _itemBox;
      await itemBox.putAll(Map<String, dynamic>.from(allData[_itemBoxName]).map((key, value) => MapEntry(key, ItemModel.fromJson(value))));

      final traitBox = await _traitBox;
      await traitBox.putAll(Map<String, dynamic>.from(allData[_traitBoxName]).map((key, value) => MapEntry(key, TraitModel.fromJson(value))));

      final routineBox = await _routineBox;
      await routineBox.putAll(Map<String, dynamic>.from(allData[_routineBoxName]).map((key, value) => MapEntry(key, RoutineModel.fromJson(value))));

      final taskBox = await _taskBox;
      await taskBox.putAll(Map<String, dynamic>.from(allData[_taskBoxName]).map((key, value) => MapEntry(key, TaskModel.fromJson(value))));
    }
  }
}
