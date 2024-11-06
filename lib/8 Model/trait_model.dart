import 'package:flutter/material.dart';
import 'package:gamify_todo/7%20Enum/trait_type_enum.dart';

class TraitModel {
  String title;
  IconData icon;
  Color? color;
  TraitTypeEnum type;

  TraitModel({
    required this.title,
    required this.icon,
    this.color,
    required this.type,
  });
}
