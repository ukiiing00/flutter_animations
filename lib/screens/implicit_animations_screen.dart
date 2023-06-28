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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Implicit Animations"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: ColorTween(
                begin: Colors.purple,
                end: Colors.red,
              ),
              curve: Curves.elasticOut,
              duration: const Duration(seconds: 25),
              builder: (context, value, child) {
                return Image.network(
                  "https://res.cloudinary.com/dnegavcrl/images/f_auto,q_auto/v1678438365/Flutter-Dash-Sticer/Flutter-Dash-Sticer.png?_i=AA",
                  color: value,
                  colorBlendMode: BlendMode.difference,
                );
              },
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
