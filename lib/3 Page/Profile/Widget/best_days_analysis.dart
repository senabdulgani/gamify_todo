import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/1%20Core/extensions.dart';
import 'package:gamify_todo/6%20Provider/profile_view_model.dart';
import 'package:provider/provider.dart';

class BestDaysAnalysis extends StatelessWidget {
  const BestDaysAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ProfileViewModel>();
    final analysis = viewModel.getBestDayAnalysis();
    final bestDay = analysis['bestDay'] as int;
    final bestAverage = analysis['bestAverage'] as Duration;

    return Column(
      children: [
        Text(
          'Best Productive Day',
          style: TextStyle(
            color: AppColors.main,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          DateFormat('EEEE').format(DateTime(2024, 1, bestDay)),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Average: ${bestAverage.textShort2()}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
