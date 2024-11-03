import 'package:flutter/material.dart';

class AddTaskProvider with ChangeNotifier {
  // Widget variables
  TextEditingController taskNameController = TextEditingController();
  TimeOfDay? selectedTime;
  DateTime? selectedDate = DateTime.now();
  bool isNotificationOn = false;
  Duration duration = const Duration(hours: 0, minutes: 0);

  // update time
  void updateTime(TimeOfDay? time) {
    selectedTime = time;

    if (selectedTime == null) {
      isNotificationOn = false;
    }

    notifyListeners();
  }

  // update date
  void updateDate(DateTime? date) {
    selectedDate = date;

    if (selectedDate == null) {
      isNotificationOn = false;
    }

    notifyListeners();
  }
}
