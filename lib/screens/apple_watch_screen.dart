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
  )..forward();

  late final CurvedAnimation _curved = CurvedAnimation(
    parent: _animationController,
    curve: Curves.bounceOut,
  );

  late List<Animation<double>> _progresses = List.generate(
    3,
    (index) => Tween(
      begin: 0.005,
      end: Random().nextDouble() * 1.9,
    ).animate(_curved),
  );

  void _animationValue() {
    _progresses = List.generate(
      3,
      (index) => Tween(
        begin: _progresses[index].value,
        end: Random().nextDouble() * 1.9,
      ).animate(_curved),
    );
    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
              progress: _progresses,
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
  final List<Animation<double>> progress;

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

    canvas.drawArc(
        redArcRect, -0.5 * pi, progress[0].value * pi, false, redArcPainter);
    canvas.drawArc(greenArcRect, -0.5 * pi, progress[1].value * pi, false,
        greenArcPainter);
    canvas.drawArc(
        blueArcRect, -0.5 * pi, progress[2].value * pi, false, blueArcPainter);
  }

  @override
  bool shouldRepaint(covariant AppleWatchPainter oldDelegate) {
    return true;
  }
}
