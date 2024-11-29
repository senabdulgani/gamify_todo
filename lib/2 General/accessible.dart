import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/7%20Enum/trait_type_enum.dart';
import 'package:gamify_todo/8%20Model/rutin_model.dart';
import 'package:gamify_todo/8%20Model/trait_model.dart';
import 'package:gamify_todo/8%20Model/user_model.dart';

// TODO: test için el ile verildi normalde veritabınndan gelecek

List<RoutineModel> routineList = [
  RoutineModel(
    id: 0,
    title: "Python",
    type: TaskTypeEnum.TIMER,
    createdDate: DateTime.now().subtract(const Duration(days: 3)),
    startDate: DateTime.now(),
    isNotificationOn: false,
    remainingDuration: const Duration(hours: 1, minutes: 0),
    repeatDays: [1, 2, 3, 4, 5, 6],
    isCompleted: false,
    attirbuteIDList: [1, 2],
    skillIDList: [1],
  ),
  RoutineModel(
    id: 1,
    title: "Meditasyon",
    type: TaskTypeEnum.TIMER,
    createdDate: DateTime.now(),
    startDate: DateTime.now(),
    isNotificationOn: false,
    remainingDuration: const Duration(minutes: 15),
    repeatDays: [6],
    isCompleted: false,
    attirbuteIDList: [1, 2],
    skillIDList: [1],
  ),
  RoutineModel(
    id: 2,
    title: "Makale oku",
    type: TaskTypeEnum.COUNTER,
    createdDate: DateTime.now(),
    startDate: DateTime.now(),
    isNotificationOn: false,
    remainingDuration: const Duration(minutes: 15),
    targetCount: 10,
    repeatDays: [1, 5, 7],
    isCompleted: false,
  ),
  RoutineModel(
    id: 3,
    title: "Su iç",
    type: TaskTypeEnum.COUNTER,
    createdDate: DateTime.now(),
    startDate: DateTime.now().subtract(const Duration(days: 3)),
    isNotificationOn: false,
    targetCount: 4,
    repeatDays: [1, 2, 3, 4, 5, 6, 7],
    isCompleted: false,
  ),
];

List<TraitModel> traitList = [
  TraitModel(
    id: 0,
    title: 'Brain',
    icon: "🧠",
    type: TraitTypeEnum.ATTIRBUTE,
    color: AppColors.red,
  ),
  TraitModel(
    id: 1,
    title: 'Health',
    icon: "❤️",
    type: TraitTypeEnum.ATTIRBUTE,
    color: AppColors.blue,
  ),
  TraitModel(
    id: 2,
    title: 'Power',
    icon: "💪",
    type: TraitTypeEnum.ATTIRBUTE,
    color: AppColors.deepGreen,
  ),
  // Skill
  TraitModel(
    id: 3,
    title: 'Flutter',
    icon: "💻",
    type: TraitTypeEnum.SKILL,
    color: AppColors.red,
  ),
  TraitModel(
    id: 4,
    title: 'Python',
    icon: "💻",
    type: TraitTypeEnum.SKILL,
    color: AppColors.yellow,
  ),
  TraitModel(
    id: 5,
    title: 'Book',
    icon: "📖",
    type: TraitTypeEnum.SKILL,
    color: AppColors.deepPurple,
  ),
];

// TODO: bir değişiklik olduğunda veritabanuna kaydet

UserModel user = UserModel(
  id: 1,
  username: "User15446",
  email: "m.islam0422@gmail.com",
  password: "123456",
  tasksTotalProgressForCalculateCredit: const Duration(hours: 0, minutes: 0, seconds: 0),
  userCredit: 30,
);
