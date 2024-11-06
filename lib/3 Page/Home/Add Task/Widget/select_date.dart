import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({
    super.key,
  });

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  late final addTaskProvider = context.read<AddTaskProvider>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppColors.borderRadiusAll,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: addTaskProvider.selectedDate == null
            ? const Icon(
                Icons.calendar_month,
                size: 35,
              )
            : Text(
                DateFormat(addTaskProvider.selectedDate!.year == DateTime.now().year ? "d MMM" : "d MMM y").format(addTaskProvider.selectedDate!),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime(3333),
          initialEntryMode: DatePickerEntryMode.calendarOnly,
        );

        addTaskProvider.updateDate(selectedDate);

        setState(() {});
      },
    );
  }
}
