import 'dart:math';

import 'package:flutter/material.dart';

class AppleWatchScreen extends StatefulWidget {
  const AppleWatchScreen({super.key});

  @override
  State<AppleWatchScreen> createState() => _AppleWatchScreenState();
}

class _AppleWatchScreenState extends State<AppleWatchScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 3,
    ),
    lowerBound: 0.005,
    upperBound: 2.0,
  );

  void _animationValue() {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text("Apple Watch"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => CustomPaint(
            painter: AppleWatchPainter(
              progress: _animationController.value,
            ),
            size: const Size(400, 400),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animationValue,
        child: const Icon(
          Icons.refresh,
        ),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  final double progress;

  AppleWatchPainter({
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final redCircleRadius = (size.width / 2) * 0.9;
    final greenCircleRadius = (size.width / 2) * 0.76;
    final blueCircleRadius = (size.width / 2) * 0.62;

    final redCirclePainter = Paint()
      ..color = Colors.red.shade300.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    final redArcRect = Rect.fromCircle(center: center, radius: redCircleRadius);

    final redArcPainter = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;

    // green

    final greenCirclePainter = Paint()
      ..color = Colors.green.shade300.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    final greenArcRect =
        Rect.fromCircle(center: center, radius: greenCircleRadius);

    final greenArcPainter = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;

    // blue

    final blueCirclePainter = Paint()
      ..color = Colors.cyan.shade300.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    final blueArcRect =
        Rect.fromCircle(center: center, radius: blueCircleRadius);

    final blueArcPainter = Paint()
      ..color = Colors.cyan
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;

    canvas.drawCircle(center, redCircleRadius, redCirclePainter);
    canvas.drawCircle(center, greenCircleRadius, greenCirclePainter);
    canvas.drawCircle(center, blueCircleRadius, blueCirclePainter);

    canvas.drawArc(redArcRect, -0.5 * pi, progress * pi, false, redArcPainter);
    canvas.drawArc(
        greenArcRect, -0.5 * pi, progress * pi, false, greenArcPainter);
    canvas.drawArc(
        blueArcRect, -0.5 * pi, progress * pi, false, blueArcPainter);
  }

  @override
  bool shouldRepaint(covariant AppleWatchPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
