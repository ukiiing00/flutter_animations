import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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

class _MusicPlayerDetailScreenState extends State<MusicPlayerDetailScreen>
    with TickerProviderStateMixin {
  late final AnimationController _progressContrller =
      AnimationController(vsync: this, duration: const Duration(minutes: 1))
        ..repeat(
          reverse: true,
        );

  late final AnimationController _marqueeController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 20),
  )..repeat(reverse: true);

  late final Animation<Offset> _marquee = Tween(
    begin: const Offset(0.1, 0),
    end: const Offset(-0.6, 0),
  ).animate(_marqueeController);

  late final AnimationController _playPauseController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 500,
    ),
  );

  void _onPlayPauseTap() {
    if (_playPauseController.isCompleted) {
      _playPauseController.reverse();
    } else {
      _playPauseController.forward();
    }
  }

  @override
  void dispose() {
    _playPauseController.dispose();
    _marqueeController.dispose();
    _progressContrller.dispose();
    super.dispose();
  }

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
          AnimatedBuilder(
            animation: _progressContrller,
            builder: (context, child) {
              return CustomPaint(
                size: Size(size.width - 80, 5),
                painter: ProgressBar(progressValue: _progressContrller.value),
              );
            },
          ),
          AnimatedBuilder(
            animation: _progressContrller,
            builder: (context, child) {
              final seconds =
                  Duration(seconds: (_progressContrller.value * 60).floor());
              final secondsString = seconds.toString().split('.')[0].split(':');
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Text(
                      '${secondsString[1]}:${secondsString[2]}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '01:00',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Interstellar',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SlideTransition(
            position: _marquee,
            child: const Text(
              'A FILM By Christopher Nolan - Original Motion Picture SoundTrack',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.visible,
              softWrap: false,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: _onPlayPauseTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  progress: _playPauseController,
                  size: 60,
                ),
                LottieBuilder.asset(
                  'assets/animations/play-button.json',
                  controller: _playPauseController,
                  width: 200,
                  height: 200,
                  onLoaded: (composition) {
                    _playPauseController.duration = composition.duration;
                  },
                )
              ],
            ),
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
    final progress = size.width * progressValue;

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

    final progressRRect =
        RRect.fromLTRBR(0, 0, progress, size.height, const Radius.circular(10));

    canvas.drawRRect(progressRRect, progressPaint);

    //thumb
    canvas.drawCircle(Offset(progress, size.height / 2), 5, progressPaint);
  }

  @override
  bool shouldRepaint(covariant ProgressBar oldDelegate) {
    return oldDelegate.progressValue != progressValue;
  }
}
