import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class FadeThroughScreen extends StatefulWidget {
  const FadeThroughScreen({super.key});

  @override
  State<FadeThroughScreen> createState() => _FadeThroughScreenState();
}

class _FadeThroughScreenState extends State<FadeThroughScreen> {
  int _index = 1;

  void _onNewDestination(int index) {
    _index = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fade Through'),
      ),
      body: PageTransitionSwitcher(
        duration: const Duration(seconds: 3),
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            FadeThroughTransition(
          fillColor: Colors.redAccent,
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: [
          const NavigationPage(
            key: ValueKey(0),
            text: "Profile",
            icon: Icons.person,
          ),
          const NavigationPage(
            key: ValueKey(1),
            text: "Notification",
            icon: Icons.notifications,
          ),
          const NavigationPage(
            key: ValueKey(2),
            text: "Settings",
            icon: Icons.settings,
          ),
        ][_index],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _onNewDestination,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: "Notification",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

class NavigationPage extends StatelessWidget {
  final String text;
  final IconData icon;

  const NavigationPage({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            icon,
            size: 48,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ]),
      ),
    );
  }
}
