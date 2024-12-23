import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/5%20Service/locale_keys.g.dart';

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
    // TODO: get most duration 5 skills
    // son 1 haftada en çok süre harcanan skilleri getir. ve hangi gün ne kadar süre harcanmış göster.
    // burada her şey hesaplanacak. mesela tablo çin dikeydeki süre 1,2,3h yerine belkide 2,4,6,8h olacak çübkü o gün çok çalışılmış mesela gib.

    List<LineChartBarData> dataList = [];
    // List<TraitModel> topSkillsList = [];

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

    for (int i = 0; i < 3; i++) {
      dataList.add(LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        // color: topSkillsList[i].color,
        color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withValues(alpha: 1.0),
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          // TODO: burada hangi gün ne kadar süre o yazılacak
          FlSpot(0, Random().nextDouble() * 5),
          FlSpot(1, Random().nextDouble() * 5),
          FlSpot(2, Random().nextDouble() * 5),
          FlSpot(3, Random().nextDouble() * 3),
          FlSpot(4, Random().nextDouble() * 3),
          FlSpot(5, Random().nextDouble() * 5),
          FlSpot(6, Random().nextDouble() * 5),
        ],
      ));
    }

    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) => Colors.blueGrey.withValues(alpha: 0.8),
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
