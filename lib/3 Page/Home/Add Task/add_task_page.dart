import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/Enums/status_enum.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/2%20General/accessible.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/duraiton_picker.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/notification_switch.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_date.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_days.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_task_type.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_time.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_trait.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/task_name.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/7%20Enum/trait_type_enum.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({
    super.key,
    this.editTask,
  });

  final TaskModel? editTask;

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late final addTaskProvider = context.read<AddTaskProvider>();
  late final taskProvider = context.read<TaskProvider>();

  bool isLoadign = false;

  @override
  void initState() {
    super.initState();

    if (widget.editTask != null) {
      addTaskProvider.taskNameController.text = widget.editTask!.title;
      addTaskProvider.selectedTime = widget.editTask!.time;
      addTaskProvider.selectedDate = widget.editTask!.taskDate;
      addTaskProvider.isNotificationOn = widget.editTask!.isNotificationOn;
      addTaskProvider.targetCount = widget.editTask!.targetCount ?? 0;
      addTaskProvider.taskDuration = widget.editTask!.remainingDuration ?? const Duration(hours: 0, minutes: 0);
      addTaskProvider.selectedTaskType = widget.editTask!.type;
      addTaskProvider.selectedDays = widget.editTask!.rutinID == null ? [] : routineList.firstWhere((element) => element.id == widget.editTask!.rutinID).repeatDays;
      addTaskProvider.selectedTraits = traitList.where((element) => (widget.editTask!.attirbuteIDList != null && widget.editTask!.attirbuteIDList!.contains(element.id)) || (widget.editTask!.skillIDList != null && widget.editTask!.skillIDList!.contains(element.id))).toList();
    } else {
      addTaskProvider.taskNameController.clear();
      addTaskProvider.selectedTime = null;
      addTaskProvider.selectedDate = context.read<TaskProvider>().selectedDate;
      addTaskProvider.isNotificationOn = false;
      addTaskProvider.targetCount = 0;
      addTaskProvider.taskDuration = const Duration(hours: 0, minutes: 0);
      addTaskProvider.selectedTaskType = TaskTypeEnum.CHECKBOX;
      addTaskProvider.selectedDays.clear();
      addTaskProvider.selectedTraits.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editTask != null
            ? "Edit Task"
            : widget.editTask?.rutinID != null
                ? "Edit Routine"
                : "Add Task"),
        leading: InkWell(
          borderRadius: AppColors.borderRadiusAll,
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          InkWell(
            borderRadius: AppColors.borderRadiusAll,
            onTap: addTask,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Icon(Icons.check),
            ),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            TaskName(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectDate(),
                SelectTime(),
                NotificationSwitch(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DurationPickerWidget(),
                SizedBox(width: 20),
                SelectTaskType(),
              ],
            ),
            SelectDays(),
            SizedBox(height: 20),
            SelectTraitList(isSkill: false),
            SizedBox(height: 10),
            SelectTraitList(isSkill: true),
          ],
        ),
      ),
    );
  }

  void addTask() {
    // TODO: ardarda basıp yanlış kopyalar ekleyebiliyorum düzelt. bir kere basınca tekrar basılamasın tüm sayfaya olabilir.

    if (addTaskProvider.taskNameController.text.trim().isEmpty) {
      addTaskProvider.taskNameController.clear();

      Helper().getMessage(
        message: "Task name cant be empty",
        status: StatusEnum.WARNING,
      );
      return;
    }

    // eğer rutin ise başlangıç tarihi geçmiş olamaz
    if (addTaskProvider.selectedDays.isNotEmpty && Helper().isBeforeDay(addTaskProvider.selectedDate, DateTime.now())) {
      Helper().getMessage(
        message: "Rutin start date cant be before day",
        status: StatusEnum.WARNING,
      );
      return;
    }

    if (isLoadign) return;

    isLoadign = true;

    if (widget.editTask != null) {
      taskProvider.editTask(
        selectedDays: addTaskProvider.selectedDays,
        taskModel: TaskModel(
          id: widget.editTask!.id,
          rutinID: widget.editTask!.rutinID,
          title: addTaskProvider.taskNameController.text,
          type: addTaskProvider.selectedTaskType,
          taskDate: addTaskProvider.selectedDate,
          time: addTaskProvider.selectedTime,
          isNotificationOn: addTaskProvider.isNotificationOn,
          currentDuration: addTaskProvider.selectedTaskType == TaskTypeEnum.TIMER ? widget.editTask!.currentDuration ?? const Duration(seconds: 0) : null,
          remainingDuration: addTaskProvider.taskDuration,
          currentCount: addTaskProvider.selectedTaskType == TaskTypeEnum.COUNTER ? widget.editTask!.currentCount ?? 0 : null,
          targetCount: addTaskProvider.targetCount,
          isTimerActive: addTaskProvider.selectedTaskType == TaskTypeEnum.TIMER ? false : null,
          attirbuteIDList: addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.ATTIRBUTE).map((e) => e.id).toList(),
          skillIDList: addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.SKILL).map((e) => e.id).toList(),
        ),
      );
    } else {
      if (addTaskProvider.selectedDays.isEmpty) {
        taskProvider.addTask(
          TaskModel(
            id: taskProvider.taskList.length,
            title: addTaskProvider.taskNameController.text,
            type: addTaskProvider.selectedTaskType,
            taskDate: addTaskProvider.selectedDate,
            time: addTaskProvider.selectedTime,
            isNotificationOn: addTaskProvider.isNotificationOn,
            currentDuration: addTaskProvider.selectedTaskType == TaskTypeEnum.TIMER ? Duration.zero : null,
            remainingDuration: addTaskProvider.taskDuration,
            currentCount: addTaskProvider.selectedTaskType == TaskTypeEnum.COUNTER ? 0 : null,
            targetCount: addTaskProvider.targetCount,
            isTimerActive: addTaskProvider.selectedTaskType == TaskTypeEnum.TIMER ? false : null,
            attirbuteIDList: addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.ATTIRBUTE).map((e) => e.id).toList(),
            skillIDList: addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.SKILL).map((e) => e.id).toList(),
          ),
        );
      } else {
        addTaskProvider.addRutin();

        if (addTaskProvider.selectedDays.contains(DateTime.now().weekday - 1) && (Helper().isBeforeOrSameDay(addTaskProvider.selectedDate, DateTime.now()))) {
          taskProvider.addTask(
            TaskModel(
              id: taskProvider.taskList.length,
              // TODO: !!!! id ler yanlış olacak gibi kontrol et
              rutinID: routineList.length - 1,
              title: addTaskProvider.taskNameController.text,
              type: addTaskProvider.selectedTaskType,
              taskDate: addTaskProvider.selectedDate,
              time: addTaskProvider.selectedTime,
              isNotificationOn: addTaskProvider.isNotificationOn,
              currentDuration: addTaskProvider.selectedTaskType == TaskTypeEnum.TIMER ? Duration.zero : null,
              remainingDuration: addTaskProvider.taskDuration,
              currentCount: addTaskProvider.selectedTaskType == TaskTypeEnum.COUNTER ? 0 : null,
              targetCount: addTaskProvider.targetCount,
              isTimerActive: addTaskProvider.selectedTaskType == TaskTypeEnum.TIMER ? false : null,
              attirbuteIDList: addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.ATTIRBUTE).map((e) => e.id).toList(),
              skillIDList: addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.SKILL).map((e) => e.id).toList(),
            ),
          );
        }
      }
    }

    Get.back();
  }
}
