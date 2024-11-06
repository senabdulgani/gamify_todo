import 'package:flutter/material.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:provider/provider.dart';

class SelectTrait extends StatefulWidget {
  const SelectTrait({
    super.key,
    required this.isSkill,
  });

  final bool isSkill;

  @override
  State<SelectTrait> createState() => _SelectTraitState();
}

class _SelectTraitState extends State<SelectTrait> {
  late final addTaskProvider = context.read<AddTaskProvider>();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
