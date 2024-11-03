import 'package:flutter/material.dart';

class AddTaskProvider with ChangeNotifier {
  // Widget variables
  TextEditingController taskNameController = TextEditingController();
  TimeOfDay? selectedTime;

  // // update time
  // void updateTime(TimeOfDay? time) {
  //   selectedTime = time;
  //   notifyListeners();
  // }
}
