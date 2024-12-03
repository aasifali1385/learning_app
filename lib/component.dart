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

Widget contentList(doc) {
  List<MapEntry<String, dynamic>> entries = doc.data().entries.toList();

  entries.sort((a, b) => a.value['show'].compareTo(b.value['show']));

  return ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: entries.length,
    itemBuilder: (BuildContext context, int index) {
      return topic(entries[index].value);
    },
  );
}

Widget topic(topic) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.all(4),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (topic['image'] != null)
          Image.network(
            topic['image'],
            frameBuilder: (context, widget, inn, boo) {
              return Container(
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.only(bottom: 4, top: 2),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(7)),
                child: widget,
              );
            },
          ),
        if (topic['title'] != null)
          Text(
            topic['title'],
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        // if (topic['desc'] != null)
        //   Text(
        //     topic['desc'],
        //     textAlign: TextAlign.justify,
        //     style: const TextStyle(fontSize: 15),
        //   ),

        if (topic['desc'] != null)
          for (int i = 0; i < topic['desc'].length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic['desc'].entries.toList()[i].value.toString(),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 16),
                ),
                if (topic['desc'].length != i + 1) const Divider(),
              ],
            ),

        ///////////////////////
      ],
    ),
  );
}
