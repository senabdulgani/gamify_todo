import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
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
import 'package:gamify_todo/5%20Service/locale_keys.g.dart';
import 'package:gamify_todo/5%20Service/navigator_service.dart';
import 'package:gamify_todo/5%20Service/server_manager.dart';
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
  bool _isIncrementing = false;

  @override
  Widget build(BuildContext context) {
    return TaskSlideActinos(
      taskModel: widget.taskModel,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          // progress(),
          InkWell(
            onTap: () {
              if (widget.taskModel.routineID != null && !Helper().isSameDay(widget.taskModel.taskDate, DateTime.now())) {
                Helper().getMessage(
                  status: StatusEnum.WARNING,
                  message: LocaleKeys.RoutineNotToday.tr(),
                );
              } else {
                taskAction();
              }
            },
            onLongPress: () async {
              if (widget.taskModel.routineID != null) {
                await NavigatorService()
                    .goTo(
                  TaskDetailPage(
                    taskModel: widget.taskModel,
                  ),
                  transition: Transition.size,
                )
                    .then(
                  (value) {
                    setState(() {});
                  },
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
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: widget.taskModel.type == TaskTypeEnum.TIMER && widget.taskModel.isTimerActive! ? null : AppColors.borderRadiusAll,
                color: widget.taskModel.type == TaskTypeEnum.TIMER && widget.taskModel.isTimerActive! ? AppColors.transparantBlack : AppColors.transparent,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      taskActionIcon(),
                      const SizedBox(width: 5),
                      titleAndDescriptionWidgets(),
                      const SizedBox(width: 10),
                      notificationWidgets(),
                    ],
                  ),
                  if (widget.taskModel.type != TaskTypeEnum.CHECKBOX) ...[
                    // const SizedBox(height: 5),
                    progressText(),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget progressText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        widget.taskModel.type == TaskTypeEnum.CHECKBOX
            ? const SizedBox()
            : widget.taskModel.type == TaskTypeEnum.COUNTER
                ? Text(
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

  AnimatedContainer progress() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 2,
      width: widget.taskModel.status == TaskStatusEnum.COMPLETED
          ? 1.sw
          : widget.taskModel.type == TaskTypeEnum.TIMER
              ? ((widget.taskModel.currentDuration?.inSeconds ?? 0) / (widget.taskModel.remainingDuration?.inSeconds ?? 1)).clamp(0.0, 1.0) * 1.sw
              : widget.taskModel.type == TaskTypeEnum.COUNTER
                  ? ((widget.taskModel.currentCount ?? 0) / (widget.taskModel.targetCount ?? 1)).clamp(0.0, 1.0) * 1.sw
                  : 0.sw,
      decoration: BoxDecoration(
        color: AppColors.deepMain,
      ),
    );
  }

  Widget taskActionIcon() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: widget.taskModel.type == TaskTypeEnum.COUNTER
          ? GestureDetector(
              onTap: () => taskAction(),
              onLongPressStart: (_) async {
                _isIncrementing = true;
                while (_isIncrementing && mounted) {
                  setState(() {
                    taskAction();
                  });
                  await Future.delayed(const Duration(milliseconds: 150));
                }
              },
              onLongPressEnd: (_) {
                _isIncrementing = false;
              },
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            )
          : Icon(
              widget.taskModel.type == TaskTypeEnum.CHECKBOX
                  ? widget.taskModel.status == TaskStatusEnum.COMPLETED
                      ? Icons.check_box
                      : Icons.check_box_outline_blank
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
      AppHelper().addCreditByProgress(widget.taskModel.remainingDuration);
    } else if (widget.taskModel.type == TaskTypeEnum.COUNTER) {
      widget.taskModel.currentCount = widget.taskModel.currentCount! + 1;

      AppHelper().addCreditByProgress(widget.taskModel.remainingDuration);

      if (widget.taskModel.currentCount! >= widget.taskModel.targetCount!) {
        widget.taskModel.status = TaskStatusEnum.COMPLETED;
      }
    } else {
      GlobalTimer().startStopTimer(
        taskModel: widget.taskModel,
      );
    }

    ServerManager().updateTask(taskModel: widget.taskModel);

    TaskProvider().updateItems();
  }

  Widget titleAndDescriptionWidgets() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText(
            widget.taskModel.title,
            maxLines: 1,
            minFontSize: 14,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              decoration: widget.taskModel.status == TaskStatusEnum.COMPLETED ? TextDecoration.lineThrough : TextDecoration.none,
              color: widget.taskModel.status == TaskStatusEnum.COMPLETED ? AppColors.dirtyWhite : null,
            ),
          ),
          if (widget.taskModel.description != null && widget.taskModel.description!.isNotEmpty)
            Text(
              widget.taskModel.description!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.dirtyWhite,
              ),
            ),
        ],
      ),
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
}
