import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/Enums/status_enum.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/2%20General/accessible.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/7%20Enum/trait_type_enum.dart';
import 'package:gamify_todo/8%20Model/trait_model.dart';
import 'package:get/route_manager.dart';

class CreateTraitDialog extends StatefulWidget {
  const CreateTraitDialog({
    super.key,
    required this.isSkill,
  });

  final bool isSkill;

  @override
  State<CreateTraitDialog> createState() => _CreateTraitDialogState();
}

class _CreateTraitDialogState extends State<CreateTraitDialog> {
  TextEditingController traitTitle = TextEditingController();
  String traitIcon = "🎯";
  Color selectedColor = AppColors.main;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Title
      title: Center(
        child: Text(
          "Create ${widget.isSkill ? "Skill" : "Attirbute"}",
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Name
          TextField(
            controller: traitTitle,
            decoration: const InputDecoration(hintText: "Name"),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              InkWell(
                borderRadius: AppColors.borderRadiusAll,
                onTap: () async {
                  traitIcon = await Helper().showEmojiPicker(context);
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.panelBackground2,
                      borderRadius: AppColors.borderRadiusAll,
                    ),
                    child: Center(
                      child: Text(
                        traitIcon,
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Color
              InkWell(
                borderRadius: AppColors.borderRadiusAll,
                onTap: () async {
                  selectedColor = await Helper().selectColor();
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: selectedColor,
                      borderRadius: AppColors.borderRadiusAll,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      actions: [
        // Camcel
        InkWell(
          borderRadius: AppColors.borderRadiusAll,
          onTap: () {
            Get.back();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.transparent,
              borderRadius: AppColors.borderRadiusAll,
            ),
            child: const Text("Cancel"),
          ),
        ),
        // Create
        InkWell(
          borderRadius: AppColors.borderRadiusAll,
          onTap: () {
            if (traitTitle.text.trim().isEmpty) {
              traitTitle.clear();

              Helper().getMessage(
                message: "Trait name cant be empty",
                status: StatusEnum.WARNING,
              );

              return;
            }

            traitList.add(TraitModel(
              title: traitTitle.text,
              icon: traitIcon,
              color: selectedColor,
              type: widget.isSkill ? TraitTypeEnum.SKILL : TraitTypeEnum.ATTIRBUTE,
            ));

            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.main,
                borderRadius: AppColors.borderRadiusAll,
              ),
              child: const Text("Create"),
            ),
          ),
        ),
      ],
    );
  }
}
