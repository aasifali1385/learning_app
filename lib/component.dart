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

      if (course.data().toString().contains('image')) const SizedBox(height: 20),
      if (course.data().toString().contains('image')) Image.network(course['image']),
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

Widget contentList(list, cid, chapter, zoom) {
  return ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: list.length,
    itemBuilder: (BuildContext context, int index) {
      return topic(list[index], index, cid, chapter, zoom);
    },
  );
}

Widget topic(topic, index, cid, chapter, zoom) {
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
        if (topic['image'] != null) image(cid, chapter, topic['image'], zoom),
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
      fontWeight: FontWeight.w600,
    ),
  );
}

Widget desc(desc) {
  final lines = desc.toString().split("\n");

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [for (var data in lines) descText(data)],
  );

  return Text(
    desc,
    textAlign: TextAlign.justify,
    style: const TextStyle(fontSize: 16),
  );
}

Widget descText(data) {
  final line = data.toString().split(":");

  if (line.length == 1) {
    return Text(line[0], textAlign: TextAlign.justify, style: const TextStyle(fontSize: 16));
  }

  if (line[0].length > 99) {
    return Text(data, textAlign: TextAlign.justify, style: const TextStyle(fontSize: 16));
  }

  return RichText(
    textAlign: TextAlign.justify,
    text: TextSpan(
      children: [
        TextSpan(
          text: "${line[0]}:",
          style: TextStyle(color: Colors.grey[800], fontSize: 16, fontWeight: FontWeight.bold),
        ),
        for (final co in line.sublist(1, line.length))
          TextSpan(text: co, style: TextStyle(color: Colors.grey[800], fontSize: 16))
      ],
    ),
  );

  return Text(
    data,
    textAlign: TextAlign.justify,
    style: const TextStyle(fontSize: 16),
  );
}

Widget image(cid, chapter, image, zoom) {
  final url =
      "https://firebasestorage.googleapis.com/v0/b/universe-25a9c.appspot.com/o/Learniverse%2F$cid%2F$chapter%2F$image?alt=media";

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
