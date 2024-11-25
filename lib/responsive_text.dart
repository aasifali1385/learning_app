import 'package:flutter/material.dart';

class ResText extends StatefulWidget {
  const ResText({super.key});

  @override
  State<ResText> createState() => _ResTextState();
}

class _ResTextState extends State<ResText> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: [
            Expanded(
              flex: 2,
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return Text(
                    "Sameple", maxLines: 1,
                    style:
                        TextStyle(fontSize: constraint.maxWidth / 3.4), //5.35),
                  );
                },
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
