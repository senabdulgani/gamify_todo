import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:provider/provider.dart';

class TaskSlideActinos extends StatefulWidget {
  const TaskSlideActinos({
    super.key,
    required this.child,
    required this.taskModel,
  });

  final Widget child;
  final TaskModel taskModel;

  @override
  State<TaskSlideActinos> createState() => _TaskSlideActinosState();
}

class _TaskSlideActinosState extends State<TaskSlideActinos> {
  late final taskProvider = context.read<TaskProvider>();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // key required for dismissible
      key: ValueKey(widget.taskModel.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.3,
        closeThreshold: 0.1,
        openThreshold: 0.1,
        dismissible: DismissiblePane(
          dismissThreshold: 0.3,
          closeOnCancel: true,
          confirmDismiss: () async {
            taskProvider.changeTaskDate(
              context: context,
              taskModel: widget.taskModel,
            );

            return false;
          },
          onDismissed: () {},
        ),
        children: [
          SlidableAction(
            onPressed: (context) {
              taskProvider.changeTaskDate(
                context: context,
                taskModel: widget.taskModel,
              );
            },
            backgroundColor: AppColors.orange,
            icon: Icons.calendar_month,
            label: 'Change Date',
            padding: const EdgeInsets.symmetric(horizontal: 5),
          ),
        ],
      ),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.5,
        closeThreshold: 0.1,
        openThreshold: 0.1,
        dismissible: DismissiblePane(
          dismissThreshold: 0.01,
          onDismissed: () {
            taskProvider.cancelTask(widget.taskModel);
          },
        ),
        children: [
          SlidableAction(
            onPressed: (context) {
              taskProvider.cancelTask(widget.taskModel);
            },
            backgroundColor: AppColors.purple,
            icon: Icons.block,
            label: 'Cancel',
            padding: const EdgeInsets.symmetric(horizontal: 5),
          ),
          SlidableAction(
            onPressed: (context) {
              taskProvider.beceremedinTask(widget.taskModel);
            },
            backgroundColor: AppColors.red,
            icon: Icons.close,
            label: 'Beceremedin',
            padding: const EdgeInsets.symmetric(horizontal: 5),
          ),
        ],
      ),
      child: widget.child,
    );
  }
}
