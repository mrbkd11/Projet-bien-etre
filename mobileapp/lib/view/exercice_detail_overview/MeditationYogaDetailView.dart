import 'package:fitnessapp/common_widgets/round_button.dart';
import 'package:fitnessapp/utils/app_colors.dart';
import 'package:fitnessapp/view/activity/widgets/upcoming_workout_row.dart';
import 'package:fitnessapp/view/activity/widgets/what_train_row.dart';
import 'package:fitnessapp/view/workour_detail_view/workour_detail_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExerciceScreen extends StatefulWidget {
  static const String routeName = "/ExerciceScreen";

  const ExerciceScreen({Key? key}) : super(key: key);

  @override
  State<ExerciceScreen> createState() => _ExerciceScreenState();
}

class _ExerciceScreenState extends State<ExerciceScreen> {
  List latestArr = [
    {
      "image": "assets/images/Workout1.png",
      "title": "Fullbody Workout",
      "time": "Today, 03:00pm"
    },
    {
      "image": "assets/images/Workout2.png",
      "title": "Upperbody Workout",
      "time": "June 05, 02:00pm"
    },
  ];

  List whatArr = [
    {
      "image": "assets/images/what_1.png",
      "title": "Fullbody Workout",
      "exercises": "11 Exercises",
      "time": "32mins"
    },
    {
      "image": "assets/images/what_2.png",
      "title": "Lowebody Workout",
      "exercises": "12 Exercises",
      "time": "40mins"
    },
    {
      "image": "assets/images/what_3.png",
      "title": "AB Workout",
      "exercises": "14 Exercises",
      "time": "20mins"
    }
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      decoration:
          BoxDecoration(gradient: LinearGradient(colors: AppColors.primaryG)),
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              title: const Text("Mindfulness Tracker",
                  style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              actions: [
                InkWell(
                  onTap: () {
                    // Action for settings or customization
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.lightGrayColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset("assets/icons/more_icon.png",
                        width: 15, height: 15, fit: BoxFit.contain),
                  ),
                ),
              ],
            ),
            SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              leadingWidth: 0,
              leading: const SizedBox(),
              expandedHeight: media.height * 0.21,
              flexibleSpace: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(enabled: false),
                    lineBarsData: lineBarsData,
                    minY: 0,
                    maxY: 50,
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 22,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              [
                                'Sun',
                                'Mon',
                                'Tue',
                                'Wed',
                                'Thu',
                                'Fri',
                                'Sat'
                              ][value.toInt() - 1],
                              style: TextStyle(
                                  color: AppColors.whiteColor, fontSize: 10),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text('$value',
                                style: TextStyle(
                                    color: AppColors.whiteColor, fontSize: 10));
                          },
                        ),
                      ),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 50,
                      height: 4,
                      decoration: BoxDecoration(
                          color: AppColors.grayColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(3)),
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor2.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Daily Workout Schedule",
                            style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 70,
                            height: 25,
                            child: RoundButton(
                              title: "Check",
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Upcoming Workout",
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "See More",
                            style: TextStyle(
                                color: AppColors.grayColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: latestArr.length,
                        itemBuilder: (context, index) {
                          var wObj = latestArr[index] as Map? ?? {};
                          return UpcomingWorkoutRow(wObj: wObj);
                        }),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "What Do You Want to Train",
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: whatArr.length,
                        itemBuilder: (context, index) {
                          var wObj = whatArr[index] as Map? ?? {};
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WorkoutDetailView(
                                              dObj: wObj,
                                            )));
                              },
                              child: WhatTrainRow(wObj: wObj));
                        }),
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  List<LineChartBarData> get lineBarsData => [
        LineChartBarData(
          isCurved: true,
          curveSmoothness: 0.2, // Adjust the curve's smoothness
          color: AppColors
              .primaryColor1, // Consider using a color that fits the meditation/yoga theme
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
              show: true,
              color: AppColors.primaryColor1.withOpacity(
                  0.1)), // Adding a subtle area color beneath the curve
          spots: const [
            FlSpot(1, 2),
            FlSpot(2, 1.5),
            FlSpot(3, 2.8),
            FlSpot(4, 2.2),
            FlSpot(5, 3),
            FlSpot(6, 2.5),
            FlSpot(7, 3.1),
          ],
        ),
        // You can add a second curve here if necessary
      ];

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 22,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      color: AppColors.whiteColor, // Adjust as necessary
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = 'Sun';
        break;
      case 2:
        text = 'Mon';
        break;
      case 3:
        text = 'Tue';
        break;
      case 4:
        text = 'Wed';
        break;
      case 5:
        text = 'Thu';
        break;
      case 6:
        text = 'Fri';
        break;
      case 7:
        text = 'Sat';
        break;
      default:
        text = '';
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10.0), // Adjust padding as necessary
      child: Text(text, style: style),
    );
  }

  SideTitles get leftTitles => SideTitles(
        showTitles: true,
        interval: 1, // Adjust the interval for better granularity
        getTitlesWidget: (value, meta) {
          var style = TextStyle(
            color: AppColors.whiteColor, // Adjust as necessary
            fontSize: 10,
          );
          // Define the text based on value
          return Text('$value', style: style);
        },
      );
}
