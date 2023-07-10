import 'package:flutter/material.dart';

class MusicPlayerDetailScreen extends StatefulWidget {
  const MusicPlayerDetailScreen({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<MusicPlayerDetailScreen> createState() =>
      _MusicPlayerDetailScreenState();
}

class _MusicPlayerDetailScreenState extends State<MusicPlayerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interstellar'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Align(
            child: Hero(
              tag: widget.index,
              child: Container(
                height: 320,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(-2, 2))
                  ],
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/covers/${widget.index}.jpeg"),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          CustomPaint(
            size: Size(size.width - 80, 5),
            painter: ProgressBar(progressValue: 10),
          ),
        ],
      ),
    );
  }
}

class ProgressBar extends CustomPainter {
  final double progressValue;

  ProgressBar({required this.progressValue});

  @override
  void paint(Canvas canvas, Size size) {
    // track
    final trackPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.fill;
    final trackRReck = RRect.fromLTRBR(
        0, 0, size.width, size.height, const Radius.circular(10));

    canvas.drawRRect(trackRReck, trackPaint);

    // progress
    final progressPaint = Paint()
      ..color = Colors.grey.shade500
      ..style = PaintingStyle.fill;

    final progressRRect = RRect.fromLTRBR(
        0, 0, progressValue, size.height, const Radius.circular(10));

    canvas.drawRRect(progressRRect, progressPaint);

    //thumb

    canvas.drawCircle(Offset(progressValue, size.height / 2), 5, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
