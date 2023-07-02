import 'dart:math';

import 'package:flutter/material.dart';

class SwipingCardsScreen extends StatefulWidget {
  const SwipingCardsScreen({super.key});

  @override
  State<SwipingCardsScreen> createState() => _SwipingCardsScreenState();
}

class _SwipingCardsScreenState extends State<SwipingCardsScreen>
    with SingleTickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;

  double posX = 0;

  late final AnimationController _position = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
    lowerBound: (size.width + 100) * -1,
    upperBound: size.width + 100,
    value: 0.0,
  );

  final Tween<double> _rotation = Tween(
    begin: -15,
    end: 15,
  );

  final Tween<double> _scale = Tween(
    begin: 0.8,
    end: 1.0,
  );

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _position.value += details.delta.dx;
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    late final bound = size.width - 200;
    final dropZone = size.width + 100;
    if (_position.value.abs() >= bound) {
      _position.value.isNegative
          ? _position.animateTo(dropZone * -1)
          : _position.animateTo(dropZone);
    } else {
      _position.animateTo(0, curve: Curves.bounceOut);
    }
  }

  @override
  void dispose() {
    _position.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Swiping Cards"),
      ),
      body: AnimatedBuilder(
        animation: _position,
        builder: (context, child) {
          final angle = _rotation
              .transform((_position.value + size.width / 2) / size.width);
          final scale = _scale.transform(_position.value.abs() / size.width);
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 100,
                child: Transform.scale(
                  scale: scale,
                  child: Material(
                    elevation: 10,
                    color: Colors.blue.shade100,
                    child: SizedBox(
                      width: size.width * 0.8,
                      height: size.height * 0.5,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                child: GestureDetector(
                  onHorizontalDragUpdate: _onHorizontalDragUpdate,
                  onHorizontalDragEnd: _onHorizontalDragEnd,
                  child: Transform.translate(
                    offset: Offset(_position.value, 0),
                    child: Transform.rotate(
                      angle: angle * (pi / 180),
                      child: Material(
                        elevation: 10,
                        color: Colors.red.shade100,
                        child: SizedBox(
                          width: size.width * 0.8,
                          height: size.height * 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
