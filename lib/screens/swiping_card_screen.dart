import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SwipingCardsScreen extends StatefulWidget {
  const SwipingCardsScreen({super.key});

  @override
  State<SwipingCardsScreen> createState() => _SwipingCardsScreenState();
}

class _SwipingCardsScreenState extends State<SwipingCardsScreen>
    with SingleTickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;

  double posX = 0;

  Color? _badColor;
  Color? _goodColor;
  Color? _badButtonColor;
  Color? _goodButtonColor;

  late final AnimationController _position = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
    lowerBound: (size.width + 200) * -1,
    upperBound: size.width + 200,
    value: 0.0,
  )
    ..addListener(() {
      _position.value.isNegative
          ? _badColor = ColorTween(
              begin: Colors.white,
              end: Colors.red,
            ).transform(_position.value.abs() / size.width)
          : _goodColor = ColorTween(
              begin: Colors.white,
              end: Colors.green,
            ).transform(_position.value.abs() / size.width);
      _position.value.isNegative
          ? _badButtonColor = ColorTween(
              end: Colors.white,
              begin: Colors.red,
            ).transform(_position.value.abs() / size.width)
          : _goodButtonColor = ColorTween(
              end: Colors.white,
              begin: Colors.green,
            ).transform(_position.value.abs() / size.width);
    })
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _badColor = _goodColor = Colors.white;
        _badButtonColor = Colors.red;
      }
    });

  final Tween<double> _rotation = Tween(
    begin: -15,
    end: 15,
  );

  final Tween<double> _scale = Tween(
    begin: 0.8,
    end: 1.0,
  );

  void _whenComplete() {
    _position.value = 0;
    setState(() {
      _index = _index == 5 ? 1 : _index + 1;
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _position.value += details.delta.dx;
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    late final bound = size.width - 200;
    final dropZone = size.width + 200;
    if (_position.value.abs() >= bound) {
      final factor = _position.value.isNegative ? -1 : 1;
      _position.animateTo(dropZone * factor).whenComplete(_whenComplete);
    } else {
      _position.animateTo(0, curve: Curves.bounceOut);
    }
  }

  void _onGood() {
    final dropZone = size.width + 200;
    _position
        .animateTo(
          dropZone,
        )
        .whenComplete(_whenComplete);
  }

  void _onBad() {
    final dropZone = size.width + 200;
    _position
        .animateTo(
          dropZone * -1,
        )
        .whenComplete(_whenComplete);
  }

  @override
  void dispose() {
    _position.dispose();
    super.dispose();
  }

  int _index = 1;

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
                top: 40,
                child: Transform.scale(
                  scale: min(scale, 1),
                  child: Card(
                    index: _index == 5 ? 1 : _index + 1,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                child: GestureDetector(
                  onHorizontalDragUpdate: _onHorizontalDragUpdate,
                  onHorizontalDragEnd: _onHorizontalDragEnd,
                  child: Transform.translate(
                    offset: Offset(_position.value, 0),
                    child: Transform.rotate(
                      angle: angle * (pi / 180),
                      child: Card(
                        index: _index,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 60,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _onBad,
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(50),
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(color: _badColor),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.x,
                              size: 30,
                              color: _badButtonColor ?? Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: _onGood,
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(50),
                        clipBehavior: Clip.hardEdge,
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: _goodColor,
                          ),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.check,
                              size: 40,
                              color: _goodButtonColor ?? Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class Card extends StatelessWidget {
  final int index;
  const Card({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.63,
        child: Image.asset(
          "assets/covers/$index.jpeg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
