import 'package:flutter/material.dart';

Widget courseContent(course) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        course['name'],
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          // fontSize: cons.maxWidth / 10,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        course['desc'],
        // textAlign: TextAlign.justify,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          // fontSize: cons.maxWidth / 12,
        ),
      ),
      const SizedBox(height: 10),
      // Image.network(curate['image'])
      ////////////////
    ],
  );
}
