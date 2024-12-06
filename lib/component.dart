import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget courseListItem(QueryDocumentSnapshot course) {
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

      if (course.data().toString().contains('image'))
        const SizedBox(height: 20),
      if (course.data().toString().contains('image'))
        Image.network(course['image']),
      ////////////////
    ],
  );
}

Widget contentList(doc, zoom) {
  List<MapEntry<String, dynamic>> entries = doc.data().entries.toList();

  entries.sort((a, b) => a.value['show'].compareTo(b.value['show']));

  return ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: entries.length,
    itemBuilder: (BuildContext context, int index) {
      return topic(entries[index].value, zoom);
    },
  );
}

Widget topic(topic, zoom) {
  return Container(
    decoration: BoxDecoration(
      // color: Colors.grey[100],
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.all(4),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (topic['image1'] != null) image(topic['image1'], zoom),
        if (topic['title1'] != null) title(topic['title1']),
        if (topic['desc1'] != null) desc(topic['desc1']),
        if (topic['image2'] != null ||
            topic['title2'] != null ||
            topic['desc2'] != null)
          const Divider(),
        if (topic['image2'] != null) image(topic['image2'], zoom),
        if (topic['title2'] != null) title(topic['title3']),
        if (topic['desc2'] != null) desc(topic['desc2']),
        if (topic['image3'] != null ||
            topic['title3'] != null ||
            topic['desc3'] != null)
          const Divider(),
        if (topic['image3'] != null) image(topic['image3'], zoom),
        if (topic['title3'] != null) title(topic['title3']),
        if (topic['desc3'] != null) desc(topic['desc3']),
      ],
    ),
  );
}

Widget title(title) {
  return Text(
    title,
    style: const TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget desc(desc) {
  return Text(
    desc,
    textAlign: TextAlign.justify,
    style: const TextStyle(fontSize: 16),
  );
}

Widget image(image, zoom) {
  return AspectRatio(
    aspectRatio: 16 / 9,
    child: Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Transform.scale(
        scale: zoom,
        child: Image.network(
          image,
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}
