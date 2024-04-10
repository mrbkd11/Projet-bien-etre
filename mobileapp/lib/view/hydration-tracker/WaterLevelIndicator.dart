import 'package:flutter/material.dart';

class HydrationLevelIndicator extends StatefulWidget {
  final double currentLevel;
  final double goal;

  const HydrationLevelIndicator({
    Key? key,
    required this.currentLevel,
    required this.goal,
  }) : super(key: key);

  @override
  State<HydrationLevelIndicator> createState() =>
      _HydrationLevelIndicatorState();
}

class _HydrationLevelIndicatorState extends State<HydrationLevelIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(
            begin: 0.0, end: widget.currentLevel / widget.goal)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CustomPaint(
          size: Size(double.infinity, 100),
          painter: _WaterLevelPainter(_animation.value),
        ),
        Positioned(
          bottom: 10,
          child: Text(
            "${(widget.currentLevel / widget.goal * 100).toStringAsFixed(0)}% of Daily Goal (${widget.currentLevel.toStringAsFixed(1)}L / ${widget.goal}L)",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _WaterLevelPainter extends CustomPainter {
  final double percentage;

  _WaterLevelPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.lightBlueAccent, Colors.blue],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));

    final path = Path();

    // Background
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);

    // Water Level
    double waterHeight = size.height * (1 - percentage);
    path.moveTo(0, waterHeight);
    path.quadraticBezierTo(
        size.width * 0.25, waterHeight - 10, size.width * 0.5, waterHeight);
    path.quadraticBezierTo(
        size.width * 0.75, waterHeight + 10, size.width, waterHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint..color = paint.color.withOpacity(0.5));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
