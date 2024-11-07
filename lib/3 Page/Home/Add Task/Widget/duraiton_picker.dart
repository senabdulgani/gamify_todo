import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:provider/provider.dart';

class DurationPickerWidget extends StatefulWidget {
  const DurationPickerWidget({super.key});

  @override
  State<DurationPickerWidget> createState() => _DurationPickerWidgetState();
}

class _DurationPickerWidgetState extends State<DurationPickerWidget> {
  late final addTaskProvider = context.read<AddTaskProvider>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: FittedBox(
            fit: BoxFit.contain,
            child: DurationPicker(
              duration: addTaskProvider.taskDuration,
              onChange: (selectedDuration) {
                var round = (selectedDuration.inMinutes / 5).round() * 5;
                setState(
                  () {
                    addTaskProvider.taskDuration = Duration(minutes: round);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
