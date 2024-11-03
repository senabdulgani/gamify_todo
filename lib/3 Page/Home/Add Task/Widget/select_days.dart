import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:provider/provider.dart';

class SelectDays extends StatefulWidget {
  const SelectDays({super.key});

  @override
  State<SelectDays> createState() => _SelectDaysState();
}

class _SelectDaysState extends State<SelectDays> {
  late final addTaskProvider = context.read<AddTaskProvider>();

  List<String> days = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: days.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return DayButton(
            index: index,
            name: days[index],
          );
        },
      ),
    );
  }
}

class DayButton extends StatefulWidget {
  const DayButton({super.key, required this.index, required this.name});

  final int index;
  final String name;

  @override
  State<DayButton> createState() => _DayButtonState();
}

class _DayButtonState extends State<DayButton> {
  late final addTaskProvider = context.read<AddTaskProvider>();

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: AppColors.borderRadiusCircular,
      ),
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });

        if (addTaskProvider.selectedDays.contains(widget.index)) {
          addTaskProvider.selectedDays.remove(widget.index);
        } else {
          addTaskProvider.selectedDays.add(widget.index);
        }
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.blue : AppColors.grey,
            borderRadius: AppColors.borderRadiusCircular,
          ),
          child: Center(
            child: Text(
              widget.name,
            ),
          ),
        ),
      ),
    );
  }
}
