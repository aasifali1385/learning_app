import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MasonryGridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemBuilder: (context, index) {
            return Tile(
              index: index,
              extent: (index % 5 + 1) * 100,
            );
          },
        );
    );

    return GridView.builder(
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // mainAxisSpacing: 4,
        // crossAxisSpacing: 4,
        // childAspectRatio: 0.5
        // childAspectRatio: 3 / 4,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.teal[(index % 9 + 1) * 100],
          height: 100 + random.nextDouble() * 200,
          child: Center(
            child: Text(
              'Item $index',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        );
      },
    );
  }
}
