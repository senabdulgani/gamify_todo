import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/accessible.dart';
import 'package:gamify_todo/5%20Service/server_manager.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/7%20Enum/trait_type_enum.dart';
import 'package:gamify_todo/8%20Model/rutin_model.dart';
import 'package:gamify_todo/8%20Model/trait_model.dart';

class AddTaskProvider with ChangeNotifier {
  // Widget variables
  TextEditingController taskNameController = TextEditingController();
  TimeOfDay? selectedTime;
  DateTime selectedDate = DateTime.now();
  bool isNotificationOn = false;
  int targetCount = 0;
  Duration taskDuration = const Duration(hours: 0, minutes: 0);
  TaskTypeEnum selectedTaskType = TaskTypeEnum.CHECKBOX;
  List<int> selectedDays = [];
  List<TraitModel> selectedTraits = [];

  void updateTime(TimeOfDay? time) {
    selectedTime = time;

    if (selectedTime == null) {
      isNotificationOn = false;
    }

    notifyListeners();
  }

  void addRoutine() async {
    final RoutineModel newRoutine = RoutineModel(
      title: taskNameController.text,
      type: selectedTaskType,
      createdDate: DateTime.now(),
      startDate: selectedDate,
      time: selectedTime,
      isNotificationOn: isNotificationOn,
      remainingDuration: taskDuration,
      targetCount: targetCount,
      repeatDays: selectedDays,
      attirbuteIDList: selectedTraits.where((element) => element.type == TraitTypeEnum.ATTRIBUTE).map((e) => e.id).toList(),
      skillIDList: selectedTraits.where((element) => element.type == TraitTypeEnum.SKILL).map((e) => e.id).toList(),
      isCompleted: false,
    );

    final int routineId = await ServerManager().addRoutine(routineModel: newRoutine);

    newRoutine.id = routineId;

    routineList.add(newRoutine);
  }
}
