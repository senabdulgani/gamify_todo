import 'package:gamify_todo/2%20General/accessible.dart';
import 'package:gamify_todo/5%20Service/server_manager.dart';

class AppHelper {
  void addCreditByProgress(Duration? progress) async {
    if (progress == null) return;

    user!.creditProgress += progress;

    while (user!.creditProgress.inHours >= 1) {
      user!.userCredit += 1;
      user!.creditProgress -= const Duration(hours: 1);

      await ServerManager().updateUser(userModel: user!);
    }
  }
}
