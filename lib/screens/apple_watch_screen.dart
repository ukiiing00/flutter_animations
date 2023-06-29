import 'dart:math';

import 'package:flutter/material.dart';

class AppleWatchScreen extends StatefulWidget {
  const AppleWatchScreen({super.key});

  @override
  State<AppleWatchScreen> createState() => _AppleWatchScreenState();
}

class _AppleWatchScreenState extends State<AppleWatchScreen> {
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
          child: CustomPaint(
        painter: AppleWatchPainter(),
        size: const Size(400, 400),
      )),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final redCirclePainter = Paint()
      ..color = Colors.red.shade300.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    final greenCirclePainter = Paint()
      ..color = Colors.green.shade300.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    final blueCirclePainter = Paint()
      ..color = Colors.cyan.shade300.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    final redArcRect =
        Rect.fromCircle(center: center, radius: (size.width / 2) * 0.9);

    final redArcPainter = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;

    canvas.drawCircle(center, (size.width / 2) * 0.9, redCirclePainter);
    canvas.drawCircle(center, (size.width / 2) * 0.76, greenCirclePainter);
    canvas.drawCircle(center, (size.width / 2) * 0.62, blueCirclePainter);
    canvas.drawArc(redArcRect, -0.5 * pi, 1.5 * pi, false, redArcPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
