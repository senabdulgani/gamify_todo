import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/7%20Enum/trait_type_enum.dart';
import 'package:gamify_todo/8%20Model/trait_model.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';

List<TaskModel> taskList = [];
// TODO: şuanlık el ile verildi normalde veritabınndan gelecek
List<TraitModel> traitList = [
  TraitModel(
    title: 'Brain',
    icon: Icons.agriculture_outlined,
    type: TraitTypeEnum.ATTIRBUTE,
    color: AppColors.red,
  ),
  TraitModel(
    title: 'Health',
    icon: Icons.healing,
    type: TraitTypeEnum.ATTIRBUTE,
    color: AppColors.blue,
  ),
  TraitModel(
    title: 'Power',
    icon: Icons.hdr_strong,
    type: TraitTypeEnum.ATTIRBUTE,
    color: AppColors.deepGreen,
  ),
  // Skill
  TraitModel(
    title: 'Flutter',
    icon: Icons.computer,
    type: TraitTypeEnum.SKILL,
    color: AppColors.red,
  ),
  TraitModel(
    title: 'Book',
    icon: Icons.menu_book_rounded,
    type: TraitTypeEnum.SKILL,
    color: AppColors.deepPurple,
  ),
];
