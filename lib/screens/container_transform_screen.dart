import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class ContainerTransformScreen extends StatefulWidget {
  const ContainerTransformScreen({super.key});

  @override
  State<ContainerTransformScreen> createState() =>
      _ContainerTransformScreenState();
}

class _ContainerTransformScreenState extends State<ContainerTransformScreen> {
  bool _isGrid = false;

  void _toggleGrid() {
    setState(() {
      _isGrid = !_isGrid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Container Transform"),
        actions: [
          IconButton(
            onPressed: _toggleGrid,
            icon: const Icon(Icons.grid_4x4),
          )
        ],
      ),
      body: _isGrid
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return OpenContainer(
                  closedBuilder: (context, action) => Column(
                    children: [
                      Image.asset('assets/covers/${(index % 5) + 1}.jpeg'),
                    ],
                  ),
                  openBuilder: (context, action) =>
                      ContainerDetailScreen(image: (index % 5) + 1),
                );
              },
            )
          : ListView.separated(
              itemCount: 20,
              itemBuilder: (context, index) {
                return OpenContainer(
                  closedBuilder: (context, action) {
                    return ListTile(
                      title: const Text("Dune SoundTrack"),
                      subtitle: const Text("Hans Zimmer"),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                      ),
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/covers/${(index % 5) + 1}.jpeg'),
                          ),
                        ),
                      ),
                    );
                  },
                  openBuilder: (context, action) {
                    return ContainerDetailScreen(image: (index % 5) + 1);
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
            ),
    );
  }
}

class ContainerDetailScreen extends StatelessWidget {
  const ContainerDetailScreen({
    super.key,
    required this.image,
  });

  final int image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Screen"),
      ),
      body: Column(
        children: [
          Center(child: Image.asset('assets/covers/$image.jpeg')),
        ],
      ),
    );
  }
}
