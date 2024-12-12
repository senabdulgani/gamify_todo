import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gamify_todo/1%20Core/Enums/status_enum.dart';
import 'package:gamify_todo/1%20Core/extensions.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/add_task_page.dart';
import 'package:gamify_todo/3%20Page/Home/Widget/task_slide_actions.dart';
import 'package:gamify_todo/3%20Page/Task%20Detail%20Page/task_detail_page.dart';
import 'package:gamify_todo/5%20Service/app_helper.dart';
import 'package:gamify_todo/5%20Service/global_timer.dart';
import 'package:gamify_todo/5%20Service/navigator_service.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/7%20Enum/task_status_enum.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return TaskSlideActinos(
      taskModel: widget.taskModel,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          progress(),
          InkWell(
            onTap: () {
              // rutin bugüne ait olmadığı için etkilşime bulunulamaz
              if (widget.taskModel.routineID != null && !Helper().isSameDay(widget.taskModel.taskDate, DateTime.now())) {
                Helper().getMessage(
                  status: StatusEnum.WARNING,
                  message: "Rutin bugüne ait olmadığı için etkilşime bulunulamaz" "${widget.taskModel.routineID}",
                );
              } else {
                taskAction();
              }
            },
            onLongPress: () async {
              if (widget.taskModel.routineID != null) {
                await NavigatorService().goTo(
                  TaskDetailPage(
                    taskModel: widget.taskModel,
                  ),
                  transition: Transition.size,
                );
              } else {
                await NavigatorService().goTo(
                  AddTaskPage(
                    editTask: widget.taskModel,
                  ),
                  transition: Transition.size,
                );
              }
            },
            borderRadius: AppColors.borderRadiusAll,
            child: Container(
              height: 65,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: AppColors.borderRadiusAll,
                color: widget.taskModel.type == TaskTypeEnum.TIMER && widget.taskModel.isTimerActive! ? AppColors.main : AppColors.transparent,
              ),
              child: Row(
                children: [
                  taskActionIcon(),
                  const SizedBox(width: 5),
                  titleAndProgressWidgets(),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      notificationWidgets(),
                      statusWidget(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer progress() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 2,
      width: widget.taskModel.status == TaskStatusEnum.COMPLETED
          ? 1.sw
          : widget.taskModel.type == TaskTypeEnum.TIMER
              ? widget.taskModel.currentDuration!.inMilliseconds / widget.taskModel.remainingDuration!.inMilliseconds * 1.sw
              : widget.taskModel.type == TaskTypeEnum.COUNTER
                  ? widget.taskModel.currentCount! / widget.taskModel.targetCount! * 1.sw
                  : 0.sw,
      decoration: BoxDecoration(
        color: AppColors.deepMain,
      ),
    );
  }

  Widget taskActionIcon() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Icon(
        widget.taskModel.type == TaskTypeEnum.CHECKBOX
            ? widget.taskModel.status == TaskStatusEnum.COMPLETED
                ? Icons.check_box
                : Icons.check_box_outline_blank
            : widget.taskModel.type == TaskTypeEnum.COUNTER
                ? Icons.add
                : widget.taskModel.isTimerActive!
                    ? Icons.pause
                    : Icons.play_arrow,
        size: 30,
      ),
    );
  }

  void taskAction() {
    if (widget.taskModel.type == TaskTypeEnum.CHECKBOX) {
      widget.taskModel.status = ((widget.taskModel.status == null || widget.taskModel.status != TaskStatusEnum.COMPLETED) ? TaskStatusEnum.COMPLETED : null);
    } else if (widget.taskModel.type == TaskTypeEnum.COUNTER) {
      widget.taskModel.currentCount = widget.taskModel.currentCount! + 1;

      AppHelper().addCreditByProgress(widget.taskModel.remainingDuration!);

      if (widget.taskModel.currentCount! >= widget.taskModel.targetCount!) {
        widget.taskModel.status = TaskStatusEnum.COMPLETED;
      }
    } else {
      GlobalTimer().startStopTimer(
        taskModel: widget.taskModel,
      );
    }

    TaskProvider().updateItems();
  }

  Widget titleAndProgressWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 0.65.sw,
          child: AutoSizeText(
            widget.taskModel.title,
            maxLines: widget.taskModel.type == TaskTypeEnum.CHECKBOX ? 2 : 1,
            minFontSize: 14,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decoration: widget.taskModel.status == TaskStatusEnum.COMPLETED ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
        ),
        widget.taskModel.type == TaskTypeEnum.CHECKBOX
            ? const SizedBox()
            : widget.taskModel.type == TaskTypeEnum.COUNTER
                ? Text(
                    // TODODOODODOD:
                    // 4/0 = unknown
                    "${widget.taskModel.currentCount ?? 0}/${widget.taskModel.targetCount ?? 0}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    "${widget.taskModel.remainingDuration!.inHours > 0 ? widget.taskModel.currentDuration!.textShort3() : widget.taskModel.currentDuration!.textShort2()}/${widget.taskModel.remainingDuration!.textShortDynamic()}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
      ],
    );
  }

  Widget notificationWidgets() {
    return Row(
      children: [
        if (widget.taskModel.time != null) ...[
          Text(
            widget.taskModel.time!.to24hours(),
          ),
          const SizedBox(width: 5),
        ],
        if (widget.taskModel.isNotificationOn) ...[
          Icon(
            Icons.alarm,
            color: AppColors.deepMain,
          ),
        ],
      ],
    );
  }

  Widget statusWidget() {
    if (widget.taskModel.status == null) {
      return const SizedBox();
    } else if (widget.taskModel.status == TaskStatusEnum.COMPLETED) {
      return const Text(
        "Completed",
        style: TextStyle(
          color: AppColors.green,
          fontSize: 13,
        ),
      );
    } else if (widget.taskModel.status == TaskStatusEnum.FAILED) {
      return const Row(
        children: [
          Text(
            "Failed",
            style: TextStyle(
              color: AppColors.red,
              fontSize: 13,
            ),
          ),
          SizedBox(width: 5),
        ],
      );
    } else {
      return const Row(
        children: [
          Text(
            "Cancel",
            style: TextStyle(
              color: AppColors.purple,
              fontSize: 13,
            ),
          ),
          SizedBox(width: 5),
        ],
      );
    }
  }
}
