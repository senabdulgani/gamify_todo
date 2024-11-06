import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/extensions.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:provider/provider.dart';

class SelectTime extends StatefulWidget {
  const SelectTime({
    super.key,
  });

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  late final addTaskProvider = context.read<AddTaskProvider>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppColors.borderRadiusAll,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: addTaskProvider.selectedTime == null
            ? const Icon(
                Icons.watch_later,
                size: 35,
              )
            : Text(
                addTaskProvider.selectedTime!.to24hours(),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
      onTap: () async {
        final selectedTime = await showTimePicker(
          context: context,
          initialTime: const TimeOfDay(hour: 12, minute: 0),
          initialEntryMode: TimePickerEntryMode.dialOnly,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            );
          },
        );
        addTaskProvider.updateTime(selectedTime);
        setState(() {});
      },
    );
  }
}
