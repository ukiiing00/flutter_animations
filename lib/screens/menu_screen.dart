import 'package:flutter/material.dart';
import 'package:flutter_animations/screens/apple_watch_screen.dart';
import 'package:flutter_animations/screens/container_transform_screen.dart';
import 'package:flutter_animations/screens/explicit_animation_screen.dart';
import 'package:flutter_animations/screens/fade_through_screen.dart';
import 'package:flutter_animations/screens/implicit_animations_screen.dart';
import 'package:flutter_animations/screens/music_player_screen.dart';
import 'package:flutter_animations/screens/rive_screen.dart';
import 'package:flutter_animations/screens/shared_axis_screen.dart';
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
            ElevatedButton(
              onPressed: () => _goToPage(context, const MusicPlayerScreen()),
              child: const Text("Music Player"),
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, const RiveScreen()),
              child: const Text("Rive"),
            ),
            ElevatedButton(
              onPressed: () =>
                  _goToPage(context, const ContainerTransformScreen()),
              child: const Text("Container Transform"),
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, const SharedAxisScreen()),
              child: const Text("Shared Axix"),
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, const FadeThroughScreen()),
              child: const Text("Fade Through"),
            ),
          ],
        ),
      ),
    );
  }
}
