import 'package:fitnessapp/utils/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HistoricalIntakeTrends extends StatelessWidget {
  final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: [
              AppColors.lightGrayColor.withOpacity(0.8),
              AppColors.primaryColor1.withOpacity(0.5),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: LineChart(mainData()),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              final index = value.toInt() % weekDays.length;
              return SideTitleWidget(
                child: Text(weekDays[index],
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                axisSide: meta.axisSide,
              );
            },
            reservedSize: 42,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 2),
            FlSpot(1, 1.5),
            FlSpot(2, 2.5),
            FlSpot(3, 2),
            // Continue adding data points for each day
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, AppColors.primaryColor1],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Colors.deepPurpleAccent.withOpacity(0.4),
                AppColors.primaryColor1.withOpacity(0.4)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final spotIndex = barSpot.x.toInt();
              final spotValue = barSpot.y.toDouble();
              return LineTooltipItem(
                '${weekDays[spotIndex]}: $spotValue L',
                const TextStyle(color: Colors.white),
              );
            }).toList();
          },
        ),
        touchCallback:
            (FlTouchEvent event, LineTouchResponse? touchResponse) {},
        handleBuiltInTouches: true,
      ),
    );
  }
}
