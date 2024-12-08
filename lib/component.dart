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

Widget contentListFireStore(QueryDocumentSnapshot doc, zoom) {
  List<MapEntry<String, dynamic>> entries =
      (doc.data() as Map<String, dynamic>).entries.toList().reversed.toList();
  // entries.sort((a, b) => a.key.compareTo(b.key));
  // entries.sort((a, b) => a.value['show'].compareTo(b.value['show']));

  return ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: entries.length,
    itemBuilder: (BuildContext context, int index) {
      return null;
      // return topic(entries[index].value, index,  zoom);
    },
  );
}

Widget contentList(list, course, chapter, zoom) {
  return ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: list.length,
    itemBuilder: (BuildContext context, int index) {
      return topic(list[index], index, course, chapter, zoom);
    },
  );
}

Widget topic(topic, index, course, chapter, zoom) {
  return Container(
    // decoration: BoxDecoration(
    // color: Colors.grey[100],
    // borderRadius: BorderRadius.circular(10),
    // ),
    // margin: const EdgeInsets.all(4),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (index != 0) const Divider(),
        if (topic['image'] != null)
          image(course, chapter, topic['image'], zoom),
        if (topic['title'] != null) title(topic['title']),
        if (topic['desc'] != null) desc(topic['desc']),
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

Widget image(course, chapter, image, zoom) {
  final url =
      "https://firebasestorage.googleapis.com/v0/b/universe-25a9c.appspot.com/o/Learniverse%2F$course%2F$chapter%2F$image?alt=media";

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
          url,
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}
