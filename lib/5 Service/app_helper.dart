import 'package:gamify_todo/2%20General/accessible.dart';

class AppHelper {
  void addCreditByProgress(Duration progress) {
    user.tasksTotalProgressForCalculateCredit += progress;

    while (user.tasksTotalProgressForCalculateCredit.inHours >= 1) {
      user.userCredit += 1;
      user.tasksTotalProgressForCalculateCredit -= const Duration(hours: 1);
    }
  }
}
