import 'package:gamify_todo/8%20Model/rutin_model.dart';
import 'package:gamify_todo/8%20Model/user_model.dart';

// TODO: test için el ile verildi normalde veritabınndan gelecek

List<RoutineModel> routineList = [
  // RoutineModel(
  //   id: 0,
  //   title: "Python",
  //   type: TaskTypeEnum.TIMER,
  //   createdDate: DateTime.now().subtract(const Duration(days: 3)),
  //   startDate: DateTime.now(),
  //   isNotificationOn: false,
  //   remainingDuration: const Duration(hours: 1, minutes: 0),
  //   repeatDays: [1, 2, 3, 4, 5, 6],
  //   isCompleted: false,
  //   attirbuteIDList: [1, 2],
  //   skillIDList: [1],
  // ),
  // RoutineModel(
  //   id: 1,
  //   title: "Meditasyon",
  //   type: TaskTypeEnum.TIMER,
  //   createdDate: DateTime.now(),
  //   startDate: DateTime.now(),
  //   isNotificationOn: false,
  //   remainingDuration: const Duration(minutes: 15),
  //   repeatDays: [6],
  //   isCompleted: false,
  //   attirbuteIDList: [1, 2],
  //   skillIDList: [1],
  // ),
  // RoutineModel(
  //   id: 2,
  //   title: "Makale oku",
  //   type: TaskTypeEnum.COUNTER,
  //   createdDate: DateTime.now(),
  //   startDate: DateTime.now(),
  //   isNotificationOn: false,
  //   remainingDuration: const Duration(minutes: 15),
  //   targetCount: 10,
  //   repeatDays: [1, 5],
  //   isCompleted: false,
  // ),
  // RoutineModel(
  //   id: 3,
  //   title: "Su iç",
  //   type: TaskTypeEnum.COUNTER,
  //   createdDate: DateTime.now(),
  //   startDate: DateTime.now().subtract(const Duration(days: 3)),
  //   isNotificationOn: false,
  //   targetCount: 4,
  //   repeatDays: [1, 2, 3, 4, 5, 6],
  //   isCompleted: false,
  // ),
];

// TODO: login register / auto login
UserModel? user = UserModel(
  id: 1,
  email: "user_mda@gmail.com",
  password: "123456",
  creditProgress: const Duration(hours: 0, minutes: 0, seconds: 0),
  userCredit: 30,
);
