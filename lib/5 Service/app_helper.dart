import 'package:gamify_todo/2%20General/accessible.dart';

class AppHelper {
  void addCreditByProgress(Duration progress) {
    user!.creditProgress += progress;

    while (user!.creditProgress.inHours >= 1) {
      user!.userCredit += 1;
      user!.creditProgress -= const Duration(hours: 1);
    }
  }
}
