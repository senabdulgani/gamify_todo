import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/6%20Provider/profile_view_model.dart';
import 'package:provider/provider.dart';

class StreakAnalysis extends StatelessWidget {
  const StreakAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ProfileViewModel>();
    final streaks = viewModel.getStreakAnalysis();

    return Column(
      children: [
        Text(
          'Streaks',
          style: TextStyle(
            color: AppColors.main,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStreakDisplay('Current', streaks['currentStreak']!),
            _buildStreakDisplay('Longest', streaks['longestStreak']!),
          ],
        ),
      ],
    );
  }

  Widget _buildStreakDisplay(String label, int days) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          '$days days',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
