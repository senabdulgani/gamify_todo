import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/accessible.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/trait_item.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:gamify_todo/7%20Enum/trait_type_enum.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              " ${widget.isSkill ? "Skill" : "Attirbute"}",
              style: TextStyle(
                color: AppColors.text,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            InkWell(
              borderRadius: AppColors.borderRadiusAll / 2,
              onTap: () {
                // TODO: create trait
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: widget.isSkill ? traitList.where((trait) => trait.type == TraitTypeEnum.SKILL).map((skill) => TraitItem(trait: skill)).toList() : traitList.where((trait) => trait.type == TraitTypeEnum.ATTIRBUTE).map((attirbute) => TraitItem(trait: attirbute)).toList(),
          ),
        )
      ],
    );
  }
}
