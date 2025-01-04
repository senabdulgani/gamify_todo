import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/1%20Core/extensions.dart';

class BestDaysAnalysis extends StatelessWidget {
  const BestDaysAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate productivity by day of week
    Map<int, Duration> dayTotals = {};
    Map<int, int> dayCount = {};

    for (var task in TaskProvider().taskList) {
      int weekday = task.taskDate.weekday;
      Duration taskDuration = task.remainingDuration!;

      dayTotals[weekday] = (dayTotals[weekday] ?? Duration.zero) + taskDuration;
      dayCount[weekday] = (dayCount[weekday] ?? 0) + 1;
    }

    // Calculate averages and find best day
    Map<int, Duration> dayAverages = {};
    int bestDay = 1;
    Duration bestAverage = Duration.zero;

    for (var entry in dayTotals.entries) {
      Duration average = entry.value ~/ dayCount[entry.key]!;
      dayAverages[entry.key] = average;

      if (average > bestAverage) {
        bestAverage = average;
        bestDay = entry.key;
      }
    }

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
