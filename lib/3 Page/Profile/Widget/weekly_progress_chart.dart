import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/5%20Service/locale_keys.g.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/6%20Provider/trait_provider.dart';
import 'package:gamify_todo/7%20Enum/task_status_enum.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/trait_model.dart';
import 'package:provider/provider.dart';

// TODO:
// TODO:
// TODO:
// TODO:
// TODO:
// TODO:

class WeeklyProgressChart extends StatefulWidget {
  const WeeklyProgressChart({super.key});

  @override
  State<StatefulWidget> createState() => WeeklyProgressChartState();
}

class WeeklyProgressChartState extends State<WeeklyProgressChart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                LocaleKeys.WeeklyProgress.tr(),
                style: TextStyle(
                  color: AppColors.main,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 16, left: 6),
                  child: _LineChart(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LineChart extends StatelessWidget {
  const _LineChart();

  @override
  Widget build(BuildContext context) {
    // Get top 3 most used skills in the last week
    List<TraitModel> topSkillsList = [];
    Map<int, Map<DateTime, Duration>> skillDurations = {};

    // Calculate skill durations for each day in the last week
    for (var task in TaskProvider().taskList) {
      if (task.taskDate
          .isAfter(DateTime.now().subtract(const Duration(days: 7)))) {
        if (task.skillIDList != null) {
          for (var skillId in task.skillIDList!) {
            skillDurations[skillId] ??= {};

            // Get the task duration
            Duration taskDuration = task.type == TaskTypeEnum.CHECKBOX
                ? (task.status == TaskStatusEnum.COMPLETED
                    ? task.remainingDuration!
                    : Duration.zero)
                : task.type == TaskTypeEnum.COUNTER
                    ? task.remainingDuration! * task.currentCount!
                    : task.currentDuration!;

            // Add duration to the skill's daily total
            DateTime dateKey = DateTime(
                task.taskDate.year, task.taskDate.month, task.taskDate.day);
            skillDurations[skillId]![dateKey] =
                (skillDurations[skillId]![dateKey] ?? Duration.zero) +
                    taskDuration;
          }
        }
      }
    }

    // Get top 3 skills by total duration
    var sortedSkills = skillDurations.entries.toList()
      ..sort((a, b) => b.value.values
          .fold<Duration>(Duration.zero, (p, c) => p + c)
          .compareTo(
              a.value.values.fold<Duration>(Duration.zero, (p, c) => p + c)));

    for (var entry in sortedSkills.take(3)) {
      var skill = context
          .read<TraitProvider>()
          .traitList
          .firstWhere((s) => s.id == entry.key);
      topSkillsList.add(skill);
    }

    // Create line data for each top skill
    List<LineChartBarData> dataList = [];
    for (var skill in topSkillsList) {
      var skillData = skillDurations[skill.id]!;

      dataList.add(LineChartBarData(
        isCurved: true,
        color: skill.color,
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: List.generate(7, (index) {
          DateTime date = DateTime.now().subtract(Duration(days: 6 - index));
          date = DateTime(date.year, date.month, date.day);
          return FlSpot(
            index.toDouble(),
            (skillData[date]?.inHours.toDouble() ?? 0) +
                (skillData[date]?.inMinutes.remainder(60).toDouble() ?? 0) / 60,
          );
        }),
      ));
    }

    Widget bottomTitleWidgets(
      double value,
      TitleMeta meta,
    ) {
      late List<String> days;

      if (context.locale == const Locale('en', 'US')) {
        days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      } else {
        days = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];
      }

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 10,
        child: Text(
          days[value.toInt()],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );
    }

    Widget leftTitleWidgets(double value, TitleMeta meta) {
      late List<String> hours;

      if (context.locale == const Locale('en', 'US')) {
        hours = ['0h', '1h', '2h', '3h', '4h', '5h'];
      } else {
        hours = ['0s', '1s', '2s', '3s', '4s', '5s'];
      }

      return Text(hours[value.toInt()],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          textAlign: TextAlign.center);
    }

    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) =>
                Colors.blueGrey.withValues(alpha: 0.8),
          ),
        ),
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              getTitlesWidget: leftTitleWidgets,
              showTitles: true,
              interval: 1,
              reservedSize: 40,
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(color: AppColors.main),
            left: BorderSide(color: AppColors.main),
          ),
        ),
        lineBarsData: dataList,
        minX: 0,
        maxX: 6,
        maxY: 5,
        minY: 0,
      ),
    );
  }
}
