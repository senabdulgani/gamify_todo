import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/accessible.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/create_trait_dialog.dart';
import 'package:gamify_todo/3%20Page/Profile/Widget/trait_item_detailed.dart';
import 'package:gamify_todo/7%20Enum/trait_type_enum.dart';
import 'package:get/route_manager.dart';

class TraitList extends StatefulWidget {
  const TraitList({
    super.key,
    required this.isSkill,
  });

  final bool isSkill;

  @override
  State<TraitList> createState() => _TraitListState();
}

class _TraitListState extends State<TraitList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Title
            Text(
              " ${widget.isSkill ? "Skill" : "Attirbute"}",
              style: TextStyle(
                color: AppColors.text,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            // Add Button
            InkWell(
              borderRadius: AppColors.borderRadiusAll / 2,
              onTap: () async {
                await Get.dialog(
                  CreateTraitDialog(isSkill: widget.isSkill),
                ).then(
                  (value) {
                    setState(() {});
                  },
                );
              },
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ],
        ),
        // List of Traits
        Column(
          children: widget.isSkill ? traitList.where((trait) => trait.type == TraitTypeEnum.SKILL).map((skill) => TraitItemDetailed(trait: skill)).toList() : traitList.where((trait) => trait.type == TraitTypeEnum.ATTIRBUTE).map((attirbute) => TraitItemDetailed(trait: attirbute)).toList(),
        )
      ],
    );
  }
}
