import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(6),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Text('data $index');
        });
  }
}
