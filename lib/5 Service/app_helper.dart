import 'package:gamify_todo/2%20General/accessible.dart';

class AppHelper {
  void addCreditByProgress(Duration progress) {
    tasksTotalProgressForCalculateCredit += progress;

    while (tasksTotalProgressForCalculateCredit.inHours >= 1) {
      userCredit += 1;
      tasksTotalProgressForCalculateCredit -= const Duration(hours: 1);
    }
  }
}
