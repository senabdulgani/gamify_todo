import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/extensions.dart';
import 'package:gamify_todo/5%20Service/locale_keys.g.dart';
import 'package:gamify_todo/5%20Service/server_manager.dart';
import 'package:gamify_todo/7%20Enum/task_status_enum.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';

class CurrentProgressWidget extends StatefulWidget {
  final TaskModel taskModel;

  const CurrentProgressWidget({
    super.key,
    required this.taskModel,
  });

  @override
  State<CurrentProgressWidget> createState() => _CurrentProgressWidgetState();
}

class _CurrentProgressWidgetState extends State<CurrentProgressWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.taskModel.type == TaskTypeEnum.CHECKBOX) {
      return Text(
        _getCheckboxStatus(),
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      );
    } else if (widget.taskModel.type == TaskTypeEnum.COUNTER) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              if (widget.taskModel.currentCount! > 0) {
                setState(() {
                  widget.taskModel.currentCount = widget.taskModel.currentCount! - 1;
                });
                ServerManager().updateTask(taskModel: widget.taskModel);
              }
            },
            onLongPress: () {
              if (widget.taskModel.currentCount! > 20) {
                setState(() {
                  widget.taskModel.currentCount = widget.taskModel.currentCount! - 20;
                });
                ServerManager().updateTask(taskModel: widget.taskModel);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.remove, size: 30),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            "${widget.taskModel.currentCount} / ${widget.taskModel.targetCount}",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 16),
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              setState(() {
                widget.taskModel.currentCount = widget.taskModel.currentCount! + 1;
              });
              ServerManager().updateTask(taskModel: widget.taskModel);
            },
            onLongPress: () {
              setState(() {
                widget.taskModel.currentCount = widget.taskModel.currentCount! + 20;
              });
              ServerManager().updateTask(taskModel: widget.taskModel);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.add, size: 30),
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDurationControl(
            label: LocaleKeys.Hour.tr(),
            value: widget.taskModel.currentDuration?.inHours ?? 0,
            onIncrease: () {
              setState(() {
                widget.taskModel.currentDuration = (widget.taskModel.currentDuration ?? Duration.zero) + const Duration(hours: 1);
              });
              ServerManager().updateTask(taskModel: widget.taskModel);
            },
            onDecrease: () {
              if ((widget.taskModel.currentDuration?.inHours ?? 0) > 0) {
                setState(() {
                  widget.taskModel.currentDuration = (widget.taskModel.currentDuration ?? Duration.zero) - const Duration(hours: 1);
                });
                ServerManager().updateTask(taskModel: widget.taskModel);
              }
            },
            onLongIncrease: () {
              setState(() {
                widget.taskModel.currentDuration = (widget.taskModel.currentDuration ?? Duration.zero) + const Duration(hours: 5);
              });
              ServerManager().updateTask(taskModel: widget.taskModel);
            },
            onLongDecrease: () {
              final currentHours = widget.taskModel.currentDuration?.inHours ?? 0;
              if (currentHours >= 5) {
                setState(() {
                  widget.taskModel.currentDuration = (widget.taskModel.currentDuration ?? Duration.zero) - const Duration(hours: 5);
                });
                ServerManager().updateTask(taskModel: widget.taskModel);
              }
            },
          ),
          const SizedBox(width: 16),
          _buildDurationControl(
            label: LocaleKeys.Minute.tr(),
            value: (widget.taskModel.currentDuration?.inMinutes ?? 0) % 60,
            onIncrease: () {
              setState(() {
                widget.taskModel.currentDuration = (widget.taskModel.currentDuration ?? Duration.zero) + const Duration(minutes: 1);
              });
              ServerManager().updateTask(taskModel: widget.taskModel);
            },
            onDecrease: () {
              if ((widget.taskModel.currentDuration?.inMinutes ?? 0) > 0) {
                setState(() {
                  widget.taskModel.currentDuration = (widget.taskModel.currentDuration ?? Duration.zero) - const Duration(minutes: 1);
                });
                ServerManager().updateTask(taskModel: widget.taskModel);
              }
            },
            onLongIncrease: () {
              setState(() {
                widget.taskModel.currentDuration = (widget.taskModel.currentDuration ?? Duration.zero) + const Duration(minutes: 15);
              });
              ServerManager().updateTask(taskModel: widget.taskModel);
            },
            onLongDecrease: () {
              final currentMinutes = widget.taskModel.currentDuration?.inMinutes ?? 0;
              if (currentMinutes >= 15) {
                setState(() {
                  widget.taskModel.currentDuration = (widget.taskModel.currentDuration ?? Duration.zero) - const Duration(minutes: 15);
                });
                ServerManager().updateTask(taskModel: widget.taskModel);
              }
            },
          ),
          const SizedBox(width: 16),
          _buildDurationControl(
            label: LocaleKeys.Second.tr(),
            value: (widget.taskModel.currentDuration?.inSeconds ?? 0) % 60,
            onIncrease: () {
              setState(() {
                widget.taskModel.currentDuration = (widget.taskModel.currentDuration ?? Duration.zero) + const Duration(seconds: 1);
              });
              ServerManager().updateTask(taskModel: widget.taskModel);
            },
            onDecrease: () {
              if ((widget.taskModel.currentDuration?.inSeconds ?? 0) > 0) {
                setState(() {
                  widget.taskModel.currentDuration = (widget.taskModel.currentDuration ?? Duration.zero) - const Duration(seconds: 1);
                });
                ServerManager().updateTask(taskModel: widget.taskModel);
              }
            },
            onLongIncrease: () {
              setState(() {
                widget.taskModel.currentDuration = (widget.taskModel.currentDuration ?? Duration.zero) + const Duration(seconds: 30);
              });
              ServerManager().updateTask(taskModel: widget.taskModel);
            },
            onLongDecrease: () {
              final currentSeconds = widget.taskModel.currentDuration?.inSeconds ?? 0;
              if (currentSeconds >= 30) {
                setState(() {
                  widget.taskModel.currentDuration = (widget.taskModel.currentDuration ?? Duration.zero) - const Duration(seconds: 30);
                });
                ServerManager().updateTask(taskModel: widget.taskModel);
              }
            },
          ),
          const SizedBox(width: 16),
          Text(
            "/ ${widget.taskModel.remainingDuration?.textShort3() ?? "0"}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      );
    }
  }

  Widget _buildDurationControl({
    required String label,
    required int value,
    required VoidCallback onIncrease,
    required VoidCallback onDecrease,
    required VoidCallback onLongIncrease,
    required VoidCallback onLongDecrease,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onIncrease,
          onLongPress: onLongIncrease,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.keyboard_arrow_up, size: 24),
          ),
        ),
        Text(
          value.toString().padLeft(2, '0'),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onDecrease,
          onLongPress: onLongDecrease,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.keyboard_arrow_down, size: 24),
          ),
        ),
      ],
    );
  }

  String _getCheckboxStatus() {
    switch (widget.taskModel.status) {
      case TaskStatusEnum.COMPLETED:
        return LocaleKeys.Completed.tr();
      case TaskStatusEnum.FAILED:
        return LocaleKeys.Failed.tr();
      case TaskStatusEnum.CANCEL:
        return LocaleKeys.Cancelled.tr();
      default:
        return LocaleKeys.InProgress.tr();
    }
  }
}
