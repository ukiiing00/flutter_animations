import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveScreen extends StatefulWidget {
  const RiveScreen({super.key});

  @override
  State<RiveScreen> createState() => _RiveScreenState();
}

class _RiveScreenState extends State<RiveScreen> {
  late final StateMachineController _stateMachineController;

  void _onInit(Artboard artboard) {
    _stateMachineController = StateMachineController.fromArtboard(
      artboard,
      "State Machine 1",
      onStateChange: (stateMachineName, stateName) {
        print(stateMachineName);
        print(stateName);
      },
    )!;
    artboard.addController(_stateMachineController);
  }

  void _togglePanel() {
    final input = _stateMachineController.findInput<bool>('panelActive')!;
    input.change(!input.value);
  }

  @override
  void dispose() {
    _stateMachineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 106, 52, 167),
      body: Stack(
        children: [
          RiveAnimation.asset(
            'assets/animations/stars-animation.riv',
            artboard: 'New Artboard',
            stateMachines: const ["State Machine 1"],
            onInit: _onInit,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: const Center(
                child: Text(
                  'Welcome to AI App',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
