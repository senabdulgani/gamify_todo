import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/8%20Model/trait_model.dart';

class TraitDetailPage extends StatefulWidget {
  const TraitDetailPage({
    super.key,
    required this.traitModel,
  });

  final TraitModel traitModel;

  @override
  State<TraitDetailPage> createState() => _TraitDetailPageState();
}

class _TraitDetailPageState extends State<TraitDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.traitModel.title} Detail'),
        leading: InkWell(
          borderRadius: AppColors.borderRadiusAll,
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
    );
  }
}
