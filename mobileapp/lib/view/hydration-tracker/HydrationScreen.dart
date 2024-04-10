import 'package:fitnessapp/service/HydrationService.dart';
import 'package:fitnessapp/utils/app_colors.dart';
import 'package:fitnessapp/view/hydration-tracker/HistoricalIntakeTrends.dart';
import 'package:fitnessapp/view/hydration-tracker/HydrationGoalCell.dart';
import 'package:fitnessapp/view/hydration-tracker/HydrationTipOfTheDay.dart';
import 'package:fitnessapp/view/hydration-tracker/WaterLevelIndicator.dart';
import 'package:flutter/material.dart';

class HydrationScreen extends StatefulWidget {
  static const String routeName = "/HydrationScreen";

  const HydrationScreen({Key? key}) : super(key: key);

  @override
  State<HydrationScreen> createState() => _HydrationScreenState();
}

class _HydrationScreenState extends State<HydrationScreen>
    with TickerProviderStateMixin {
  double currentHydrationLevel =
      1.5; // Example current hydration level in liters
  double hydrationGoal = 3.0; // Daily hydration goal in liters
  String userId = "66036b08fe2d6569e5efbb5c";
  final HydrationService _hydrationService = HydrationService();
  // Example userId

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 0.0, end: currentHydrationLevel / hydrationGoal)
            .animate(_controller)
          ..addListener(() {
            setState(() {});
          });

    _controller.forward();
    _fetchHydrationData();
  }

  void _fetchHydrationData() async {
    String userId = "66036b08fe2d6569e5efbb5c"; // Use the actual user ID.
    try {
      double goal = await _hydrationService.fetchDailyGoal(userId);
      double currentLevel = await _hydrationService.fetchCurrentIntake(userId);
      setState(() {
        hydrationGoal = goal;
        currentHydrationLevel = currentLevel;
      });
    } catch (e) {
      print("Error fetching hydration data: $e");
      // Handle the error, maybe show a message to the user.
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.lightGrayColor,
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.arrow_back, color: AppColors.blackColor),
          ),
        ),
        title: const Text(
          "Hydration Tracker",
          style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            children: [
              // For current intake, directly show the value without updating capability
              HydrationGoalCell(
                icon: "assets/icons/water_icon.png",
                userId: userId,
                title: "Current Intake",
                isGoalCell: false, // Indicate this is not the goal cell
              ),
              const SizedBox(height: 10),
              // For daily goal, allow updating it
              HydrationGoalCell(
                icon: "assets/icons/goal_icon.png",
                userId: userId,
                title: "Daily Goal",
                isGoalCell: true, // Indicate this is the goal cell
              ),
              const SizedBox(height: 30),
              HydrationLevelIndicator(
                currentLevel: currentHydrationLevel,
                goal: hydrationGoal,
              ),
              // const SizedBox(height: 30),
              // CustomPaint(
              //   painter: _WaterLevelPainter(_animation.value),
              //   child: SizedBox(width: double.infinity, height: 100),
              // ),
              const SizedBox(height: 30),
              MaterialButton(
                onPressed: () => _logWaterIntake(context),
                color: AppColors.primaryColor1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Text("Log Water Intake",
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 30),
              HistoricalIntakeTrends(),
              const SizedBox(height: 30),
              HydrationTipOfTheDay(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void _logWaterIntake(BuildContext context) async {
    // This function no longer needs to accept 'value' as a parameter.
    // It will be captured within '_showLogIntakeDialog'.
    _showLogIntakeDialog(context, (double value) async {
      // Assuming 'userId' is available and correctly retrieved.
      String userId =
          "66036b08fe2d6569e5efbb5c"; // Replace with actual user ID logic.
      bool result = await _hydrationService.logWaterIntake(userId, value);
      if (result) {
        print("Water intake logged successfully.");
        setState(() {
          currentHydrationLevel += value;
          // You might want to fetch the updated current level from the backend
          // after successfully logging the intake to ensure data consistency.
        });
      } else {
        print("Failed to log water intake.");
      }
    });
  }

  void _showLogIntakeDialog(
      BuildContext context, Function(double) onLogIntake) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _textController = TextEditingController();
        return AlertDialog(
          title: const Text('Log Water Intake'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextButton(
                child: const Text('250ml'),
                onPressed: () => Navigator.of(context).pop(0.25),
              ),
              TextButton(
                child: const Text('500ml'),
                onPressed: () => Navigator.of(context).pop(0.5),
              ),
              TextField(
                controller: _textController,
                decoration:
                    const InputDecoration(hintText: 'Enter custom amount (ml)'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                final double? loggedValue =
                    double.tryParse(_textController.text);
                if (loggedValue != null) {
                  Navigator.of(context)
                      .pop(loggedValue / 1000); // Convert ml to liters
                }
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    ).then((value) async {
      if (value != null) {
        // Assuming 'userId' is available
        String userId =
            "66036b08fe2d6569e5efbb5c"; // Replace with actual user ID
        bool result = await _hydrationService.logWaterIntake(userId, value);
        if (result) {
          // Handle successful water intake logging
          print("Water intake logged successfully.");
          double updatedCurrentLevel =
              await _hydrationService.fetchCurrentIntake(userId);

          // Option 2: Increment the current level locally.
          // double updatedCurrentLevel = currentHydrationLevel + value;

          setState(() {
            currentHydrationLevel = updatedCurrentLevel;
          });
        } else {
          // Handle failure
          print("Failed to log water intake.");
        }
      }
    });
  }

// class _WaterLevelPainter extends CustomPainter {
//   final double percentage;

//   _WaterLevelPainter(this.percentage);

//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint()
//       ..color = Colors.blue.withOpacity(0.7)
//       ..style = PaintingStyle.fill;
//     canvas.drawRect(
//         Rect.fromLTRB(
//             0, size.height * (1 - percentage), size.width, size.height),
//         paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Define HistoricalIntakeTrends, HydrationGoalCell with actual implementations as placeholders
