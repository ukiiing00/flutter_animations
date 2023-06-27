import 'package:flutter/material.dart';

class ImplicitAnimationScreen extends StatefulWidget {
  const ImplicitAnimationScreen({super.key});

  @override
  State<ImplicitAnimationScreen> createState() =>
      _ImplicitAnimationScreenState();
}

class _ImplicitAnimationScreenState extends State<ImplicitAnimationScreen> {
  bool _visible = true;

  void _trigger() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(_visible);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Implicit Animations"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              curve: Curves.elasticOut,
              duration: const Duration(seconds: 2),
              transform: Matrix4.rotationZ(_visible ? 1 : 0),
              transformAlignment: Alignment.center,
              decoration: BoxDecoration(
                color: _visible ? Colors.red : Colors.orange,
                borderRadius: BorderRadius.circular(
                  _visible ? 100 : 0,
                ),
              ),
              height: size.width * 0.7,
              width: size.width * 0.7,
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: _trigger,
              child: const Text("Go!"),
            ),
          ],
        ),
      ),
    );
  }
}
