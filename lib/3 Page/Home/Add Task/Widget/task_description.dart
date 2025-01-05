import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gamify_todo/5%20Service/locale_keys.g.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:provider/provider.dart';

class TaskDescription extends StatelessWidget {
  const TaskDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AddTaskProvider>();

    return Center(
      child: SizedBox(
        width: 375,
        child: TextField(
          controller: provider.descriptionController,
          decoration: InputDecoration(
            hintText: LocaleKeys.TaskDescription.tr(),
          ),
          maxLength: 200,
          maxLines: 3,
        ),
      ),
    );
  }
}
