import 'package:flutter/material.dart';
import 'package:flutter_animations/screens/apple_watch_screen.dart';
import 'package:flutter_animations/screens/explicit_animation_screen.dart';
import 'package:flutter_animations/screens/implicit_animations_screen.dart';
import 'package:flutter_animations/screens/swiping_card_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _goToPage(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Animations"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () =>
                  _goToPage(context, const ImplicitAnimationScreen()),
              child: const Text("Implicit Animations"),
            ),
            ElevatedButton(
              onPressed: () =>
                  _goToPage(context, const ExplicitAnimationScreen()),
              child: const Text("Explicit Animations"),
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, const AppleWatchScreen()),
              child: const Text("Apple Watch"),
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, const SwipingCardsScreen()),
              child: const Text("Swiping Cards"),
            ),
          ],
        ),
      ),
    );
  }
}
