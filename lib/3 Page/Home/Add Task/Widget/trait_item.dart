import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:gamify_todo/8%20Model/trait_model.dart';
import 'package:provider/provider.dart';

class TraitItem extends StatefulWidget {
  const TraitItem({
    super.key,
    required this.trait,
  });

  final TraitModel trait;

  @override
  State<TraitItem> createState() => _TraitItemState();
}

class _TraitItemState extends State<TraitItem> {
  late final addTaskProvider = context.read<AddTaskProvider>();

  late bool isSelected;

  @override
  void initState() {
    super.initState();

    isSelected = addTaskProvider.selectedTraits.contains(widget.trait);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppColors.borderRadiusAll,
      highlightColor: widget.trait.color,
      splashColor: isSelected ? null : widget.trait.color,
      onTap: () {
        if (isSelected) {
          addTaskProvider.selectedTraits.remove(widget.trait);
        } else {
          addTaskProvider.selectedTraits.add(widget.trait);
        }

        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isSelected ? widget.trait.color : AppColors.panelBackground2,
            borderRadius: AppColors.borderRadiusAll,
          ),
          child: Center(
            child: Text(
              widget.trait.icon,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
