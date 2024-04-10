import 'package:fitnessapp/service/HydrationService.dart';
import 'package:fitnessapp/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HydrationGoalCell extends StatefulWidget {
  final String icon;
  final String userId;
  final String title;
  final bool isGoalCell; // Indicates if this cell is for the daily goal

  const HydrationGoalCell({
    Key? key,
    required this.icon,
    required this.userId,
    required this.title,
    this.isGoalCell = false, // Default to false for intake cells
  }) : super(key: key);

  @override
  _HydrationGoalCellState createState() => _HydrationGoalCellState();
}

class _HydrationGoalCellState extends State<HydrationGoalCell> {
  late double _value = 0; // This will hold the current intake or goal value

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    double value;
    if (widget.isGoalCell) {
      value = await HydrationService().fetchDailyGoal(widget.userId);
    } else {
      try {
        value = await HydrationService().fetchCurrentIntake(widget.userId);
      } on Exception catch (e) {
        // Handle potential errors during data fetching
        print("Error fetching data: $e");
        return; // Exit the function if error occurs
      }
    }
    setState(() {
      _value = value;
    });
  }

  void _updateGoal(BuildContext context) async {
    if (!widget.isGoalCell) return; // Only allow updates for the goal cell

    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Update Daily Goal"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Enter new goal (L)",
            ),
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Update"),
              onPressed: () async {
                final double? newGoal = double.tryParse(controller.text);
                if (newGoal != null) {
                  await HydrationService()
                      .updateDailyGoal(widget.userId, newGoal);

                  Navigator.of(context).pop();
                  _fetchData(); // Refresh the displayed goal
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _updateGoal(context),
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(widget.icon,
                width: 40, height: 40, fit: BoxFit.contain),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${_value.toStringAsFixed(1)}L",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = LinearGradient(colors: AppColors.primaryG)
                            .createShader(
                                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                    ),
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: AppColors.grayColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
