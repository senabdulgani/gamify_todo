import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/7%20Enum/trait_type_enum.dart';
import 'package:gamify_todo/8%20Model/rutin_model.dart';
import 'package:gamify_todo/8%20Model/trait_model.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';

// TODO: test için el ile verildi normalde veritabınndan gelecek

List<TaskModel> taskList = [
  TaskModel(
    id: 0,
    rutinID: 0,
    title: "Python",
    type: TaskTypeEnum.TIMER,
    taskDate: DateTime.now(),
    isNotificationOn: false,
    currentDuration: const Duration(hours: 0, minutes: 0),
    remainingDuration: const Duration(hours: 1, minutes: 0),
    targetCount: 0,
    isCompleted: false,
    attirbuteIDList: [1, 2],
    skillIDList: [1],
  ),
  TaskModel(
    id: 1,
    title: "çöp at",
    desc: "merhaba ben çöp atma açıklamasiyim",
    type: TaskTypeEnum.CHECKBOX,
    taskDate: DateTime.now(),
    isNotificationOn: false,
    targetCount: 0,
    isCompleted: false,
  ),
  TaskModel(
    id: 2,
    rutinID: 1,
    title: "Makale oku",
    type: TaskTypeEnum.COUNTER,
    taskDate: DateTime.now(),
    isNotificationOn: false,
    currentCount: 0,
    targetCount: 10,
    remainingDuration: const Duration(minutes: 15),
    isCompleted: false,
  ),
];

List<RutinModel> rutinList = [
  RutinModel(
    id: 0,
    title: "Python",
    type: TaskTypeEnum.TIMER,
    createdDate: DateTime.now(),
    startDate: DateTime.now(),
    isNotificationOn: false,
    remainingDuration: const Duration(hours: 1, minutes: 0),
    repeatDays: [1, 5],
    isCompleted: false,
    attirbuteIDList: [1, 2],
    skillIDList: [1],
  ),
  RutinModel(
    id: 1,
    title: "Makale oku",
    type: TaskTypeEnum.COUNTER,
    createdDate: DateTime.now(),
    startDate: DateTime.now(),
    isNotificationOn: false,
    remainingDuration: const Duration(minutes: 15),
    targetCount: 10,
    repeatDays: [1, 5],
    isCompleted: false,
  )
];

List<TraitModel> traitList = [
  TraitModel(
    title: 'Brain',
    icon: "🧠",
    type: TraitTypeEnum.ATTIRBUTE,
    color: AppColors.red,
  ),
  TraitModel(
    title: 'Health',
    icon: "❤️",
    type: TraitTypeEnum.ATTIRBUTE,
    color: AppColors.blue,
  ),
  TraitModel(
    title: 'Power',
    icon: "💪",
    type: TraitTypeEnum.ATTIRBUTE,
    color: AppColors.deepGreen,
  ),
  // Skill
  TraitModel(
    title: 'Flutter',
    icon: "💻",
    type: TraitTypeEnum.SKILL,
    color: AppColors.red,
  ),
  TraitModel(
    title: 'Book',
    icon: "📖",
    type: TraitTypeEnum.SKILL,
    color: AppColors.deepPurple,
  ),
];
