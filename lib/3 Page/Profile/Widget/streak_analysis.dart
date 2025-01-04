import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/7%20Enum/task_status_enum.dart';

class StreakAnalysis extends StatelessWidget {
  const StreakAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate current and longest streaks
    int currentStreak = 0;
    int longestStreak = 0;
    int tempStreak = 0;
    DateTime? lastDate;

    // Sort tasks by date
    var sortedTasks = TaskProvider().taskList.toList()
      ..sort((a, b) => b.taskDate.compareTo(a.taskDate));

    // Calculate streaks
    for (var task in sortedTasks) {
      if (task.status == TaskStatusEnum.COMPLETED) {
        if (lastDate == null ||
            task.taskDate.difference(lastDate).inDays == 1) {
          tempStreak++;
        } else {
          tempStreak = 1;
        }
        lastDate = task.taskDate;

        longestStreak = tempStreak > longestStreak ? tempStreak : longestStreak;

        // Update current streak if this is recent
        if (DateTime.now().difference(task.taskDate).inDays <= 1) {
          currentStreak = tempStreak;
        }
      }
    }

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
            _buildStreakDisplay('Current', currentStreak),
            _buildStreakDisplay('Longest', longestStreak),
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
