import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:provider/provider.dart';

class SelectTargetCount extends StatefulWidget {
  const SelectTargetCount({
    super.key,
  });

  @override
  State<SelectTargetCount> createState() => _SelectTargetCountState();
}

class _SelectTargetCountState extends State<SelectTargetCount> {
  late final addTaskProvider = context.read<AddTaskProvider>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          borderRadius: AppColors.borderRadiusAll,
          onTap: () {
            if (addTaskProvider.targetCount > 0) {
              setState(() {
                addTaskProvider.targetCount--;
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: AppColors.borderRadiusAll,
            ),
            padding: const EdgeInsets.all(5),
            child: const Icon(
              Icons.remove,
              size: 30,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: AppColors.borderRadiusAll,
          ),
          padding: const EdgeInsets.all(5),
          child: Text(
            addTaskProvider.targetCount.toString(),
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        InkWell(
          borderRadius: AppColors.borderRadiusAll,
          onTap: () {
            setState(() {
              addTaskProvider.targetCount++;
            });
          },
          onLongPress: () {
            setState(() {
              addTaskProvider.targetCount += 20;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: AppColors.borderRadiusAll,
            ),
            padding: const EdgeInsets.all(5),
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
