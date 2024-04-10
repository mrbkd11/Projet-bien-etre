import 'package:fitnessapp/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HydrationTipOfTheDay extends StatefulWidget {
  final List<String> tips = [
    "Drinking water helps maintain the balance of body fluids.",
    "Water can help control calories.",
    "Regular hydration improves skin health and beauty.",
    "Adequate water intake prevents dehydration.",
  ];

  HydrationTipOfTheDay({Key? key}) : super(key: key);

  @override
  _HydrationTipOfTheDayState createState() => _HydrationTipOfTheDayState();
}

class _HydrationTipOfTheDayState extends State<HydrationTipOfTheDay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightFactorAnimation;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _heightFactorAnimation =
        Tween<double>(begin: 0, end: 1).animate(_controller)
          ..addListener(() {
            setState(() {});
          });
  }

  void _toggleTip() {
    setState(() {
      isExpanded = !isExpanded;
      isExpanded ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final String dailyTip =
        widget.tips[DateTime.now().day % widget.tips.length];
    return GestureDetector(
      onTap: _toggleTip,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryColor1.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tip of the Day",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: AppColors.primaryColor1,
                ),
              ],
            ),
            SizeTransition(
              sizeFactor: _heightFactorAnimation,
              axis: Axis.vertical,
              axisAlignment: -1,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(dailyTip, style: TextStyle(fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
