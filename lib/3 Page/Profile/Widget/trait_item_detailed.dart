import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/8%20Model/trait_model.dart';
import 'package:get/route_manager.dart';

class TraitItemDetailed extends StatefulWidget {
  const TraitItemDetailed({
    super.key,
    required this.trait,
  });

  final TraitModel trait;

  @override
  State<TraitItemDetailed> createState() => _TraitItemDetailedState();
}

class _TraitItemDetailedState extends State<TraitItemDetailed> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        borderRadius: AppColors.borderRadiusAll,
        highlightColor: widget.trait.color,
        splashColor: widget.trait.color,
        onTap: () {
          Get.toNamed('/traitDetail');
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppColors.borderRadiusAll,
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: Center(
                  child: Text(
                    widget.trait.icon,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    widget.trait.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "120h 28m",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Text(
                "12 LVL",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
