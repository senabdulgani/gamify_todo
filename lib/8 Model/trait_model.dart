import 'package:flutter/material.dart';
import 'package:gamify_todo/7%20Enum/trait_type_enum.dart';

class TraitModel {
  int id;
  String title;
  String icon;
  Color color;
  TraitTypeEnum type;
  bool isArchived;

  TraitModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.type,
    this.isArchived = false,
  });
}
