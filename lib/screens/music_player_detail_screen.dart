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

class _MusicPlayerDetailScreenState extends State<MusicPlayerDetailScreen>
    with TickerProviderStateMixin {
  bool isDragging = false;

  void _toggleDragging() {
    setState(() {
      isDragging = !isDragging;
    });
  }

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
    begin: const Offset(0.02, 0),
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

  late final AnimationController _menuController = AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 2,
    ),
    reverseDuration: const Duration(
      seconds: 1,
    ),
  );

  late final Curve _menuCurve = Curves.easeInOutCubic;

  late final Animation<double> _screenScale = Tween(
    begin: 1.0,
    end: 0.7,
  ).animate(
    CurvedAnimation(
      parent: _menuController,
      curve: Interval(0.0, 0.3, curve: _menuCurve),
    ),
  );

  late final Animation<Offset> _screenOffset = Tween(
    begin: const Offset(0, 0),
    end: const Offset(0.3, 0),
  ).animate(
    CurvedAnimation(
      parent: _menuController,
      curve: Interval(0.2, 0.4, curve: _menuCurve),
    ),
  );

  late final Animation<double> _closeButtonOpacity = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(
    CurvedAnimation(
      parent: _menuController,
      curve: Interval(0.2, 0.5, curve: _menuCurve),
    ),
  );

  late final List<Animation<Offset>> _menuAnimations = [
    for (var i = 0; i < _menus.length; i++)
      Tween(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _menuController,
          curve: Interval(0.4 + (0.1 * i), 0.7 + (0.1 * i), curve: _menuCurve),
        ),
      ),
  ];

  late final Animation<Offset> _logoutSlide = Tween(
    begin: const Offset(-1, 0),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _menuController,
      curve: Interval(0.8, 1.0, curve: _menuCurve),
    ),
  );

  @override
  void dispose() {
    _playPauseController.dispose();
    _marqueeController.dispose();
    _progressContrller.dispose();
    _menuController.dispose();
    super.dispose();
  }

  late final size = MediaQuery.of(context).size;

  final ValueNotifier<double> _volume = ValueNotifier(0.0);

  void _onVolumeDragUpdate(DragUpdateDetails details) {
    _volume.value += details.delta.dx;
    _volume.value = _volume.value.clamp(0.0, size.width - 80);
  }

  void _openMenu() {
    _menuController.forward();
  }

  void _closeMenu() {
    _menuController.reverse();
  }

  final List<Map<String, dynamic>> _menus = [
    {
      "icon": Icons.person,
      "text": "Profile",
    },
    {
      "icon": Icons.notifications,
      "text": "Notifications",
    },
    {
      "icon": Icons.settings,
      "text": "Settings",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: FadeTransition(
              opacity: _closeButtonOpacity,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.grey.shade200,
                ),
                onPressed: _closeMenu,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                for (var i = 0; i < _menus.length; i++) ...[
                  SlideTransition(
                    position: _menuAnimations[i],
                    child: Row(
                      children: [
                        Icon(
                          _menus[i]['icon'],
                          color: Colors.grey.shade200,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _menus[i]['text'],
                          style: TextStyle(
                            color: Colors.grey.shade200,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
                const Spacer(),
                SlideTransition(
                  position: _logoutSlide,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Log out",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
        SlideTransition(
          position: _screenOffset,
          child: ScaleTransition(
            scale: _screenScale,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Interstellar'),
                actions: [
                  IconButton(
                    onPressed: _openMenu,
                    icon: const Icon(
                      Icons.menu,
                    ),
                  )
                ],
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
                            image: AssetImage(
                                "assets/covers/${widget.index}.jpeg"),
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
                        painter: ProgressBar(
                            progressValue: _progressContrller.value),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _progressContrller,
                    builder: (context, child) {
                      final seconds = Duration(
                        seconds: (_progressContrller.value * 60).floor(),
                      );
                      final secondsString =
                          seconds.toString().split('.')[0].split(':');
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
                  SizedBox(
                    height: 30,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          SlideTransition(
                            position: _marquee,
                            child: const Text(
                              'A FILM By Christopher Nolan - Original Motion Picture SoundTrack',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
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
                        // LottieBuilder.asset(
                        //   'assets/animations/play-button.json',
                        //   controller: _playPauseController,
                        //   width: 200,
                        //   height: 200,
                        //   onLoaded: (composition) {
                        //     _playPauseController.duration = composition.duration;
                        //   },
                        // )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onHorizontalDragUpdate: (details) =>
                        _onVolumeDragUpdate(details),
                    onHorizontalDragStart: (_) => _toggleDragging(),
                    onHorizontalDragEnd: (_) => _toggleDragging(),
                    child: AnimatedScale(
                      scale: isDragging ? 1.1 : 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.bounceOut,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ValueListenableBuilder(
                          valueListenable: _volume,
                          builder: (context, value, child) => CustomPaint(
                            size: Size(size.width - 80, 50),
                            painter: VolumePainter(
                              volume: value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class VolumePainter extends CustomPainter {
  final double volume;

  VolumePainter({
    required this.volume,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final progress = volume;

    final bgPaint = Paint()..color = Colors.grey.shade300;
    final bgRect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawRect(bgRect, bgPaint);

    final volumePaint = Paint()..color = Colors.grey.shade500;
    final volumeRect = Rect.fromLTWH(0, 0, volume, size.height);

    canvas.drawRect(volumeRect, volumePaint);
  }

  @override
  bool shouldRepaint(covariant VolumePainter oldDelegate) {
    return oldDelegate.volume != volume;
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
