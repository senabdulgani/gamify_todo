import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/extensions.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';

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
    return InkWell(
      onTap: () {
        // ??? direkt containere basınca da icon butona basmış gibi mi osun emin olamadım deneyeceğim.

        // task detaylarına git ordan da düzenlemek için ayrı gidecek
      },
      onLongPress: () {
        // taskı tamamlayamadın
      },
      borderRadius: AppColors.borderRadiusAll,
      child: Container(
        height: 70,
        color: AppColors.transparent,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            taskActionIcon(),
            const SizedBox(width: 10),
            titleAndCountWidgets(),
            const Spacer(),
            notificationWidgets(),
          ],
        ),
      ),
    );
  }

  Widget taskActionIcon() {
    return InkWell(
      borderRadius: AppColors.borderRadiusAll,
      onTap: () {
        if (widget.taskModel.type == TaskTypeEnum.CHECKBOX) {
          widget.taskModel.isCompleted = !widget.taskModel.isCompleted;
        } else if (widget.taskModel.type == TaskTypeEnum.COUNTER) {
          widget.taskModel.currentCount = widget.taskModel.currentCount! + 1;
        } else {
          widget.taskModel.isTimerActive = !widget.taskModel.isTimerActive!;
        }

        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Icon(
          widget.taskModel.type == TaskTypeEnum.CHECKBOX
              ? widget.taskModel.isCompleted
                  ? Icons.check_box
                  : Icons.check_box_outline_blank
              : widget.taskModel.type == TaskTypeEnum.COUNTER
                  ? Icons.add
                  : widget.taskModel.isTimerActive!
                      ? Icons.pause
                      : Icons.play_arrow,
          size: 30,
        ),
      ),
    );
  }

  Widget titleAndCountWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.taskModel.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        widget.taskModel.type == TaskTypeEnum.CHECKBOX
            ? const SizedBox()
            : widget.taskModel.type == TaskTypeEnum.COUNTER
                ? Text(
                    "${widget.taskModel.currentCount ?? 0}/${widget.taskModel.targetCount ?? 0}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    "${widget.taskModel.remainingDuration!.inHours > 0 ? widget.taskModel.currentDuration!.textShort3() : widget.taskModel.currentDuration!.textShort2()}/${widget.taskModel.remainingDuration!.textShortDynamic()}",
                    style: const TextStyle(
                      fontSize: 15,
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
}
