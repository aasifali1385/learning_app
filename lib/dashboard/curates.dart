import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:learning_app/colors.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  var curates = [];

  @override
  void initState() {
    super.initState();

    final db = FirebaseFirestore.instance;

    db.collection('Curates').get().then((coll) {
      // print('Data=>${coll.docs.first['name']}');
      curates = coll.docs;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: MyColors.gradient2),
          ),
        ),
        /////////////////
        SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    // Icon(
                    //   Icons.school_outlined,
                    //   color: Colors.white,
                    //   size: 34,
                    // ),
                    SizedBox(width: 10),
                    Text(
                      'Curates',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ////////////////////////////////
              Expanded(
                child: Card(
                    margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    elevation: 4,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: MasonryGridView.count(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 9),
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      itemCount: curates.length,
                      itemBuilder: (context, index) {
                        return curate(curates[index]);
                      },
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget curate(curate) {
  return Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    child: Container(
      decoration: BoxDecoration(
          // gradient: LinearGradient(colors: MyColors.gradient1),
          ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            curate['name'],
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            curate['desc'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          // Image.network(curate['image'])

          ////////////////
        ],
      ),
    ),
  );
}

Widget item1() {
  return Card(
    elevation: 4,
    margin: const EdgeInsets.all(8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    clipBehavior: Clip.antiAlias,
    child: Container(
      decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //     begin: Alignment.topRight,
          //     end: Alignment.bottomLeft,
          //     colors: [Color(0xffbf0160), Color(0xff530270)]),
          ),
      child: const AspectRatio(aspectRatio: 1 / 1.4, child: Column()),
    ),
  );
}

Widget searchBar() {
  return Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    // margin: const EdgeInsets.symmetric(horizontal: 50),
    child: TextField(
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
          hintText: 'Search...',
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(2),
            child: IconButton(
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              icon: const Icon(
                Icons.search_rounded,
                color: Colors.white,
              ),
            ),
          )),
    ),
  );
}

Widget item2() {
  return const Column(
    children: [
      Card(
        color: Colors.black,
        elevation: 4,
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.cloud_rounded,
            size: 40,
            color: Colors.white,
            // shadows: [Shadow(offset: Offset(2, 2), color: Colors.black26)],
          ),
        ),
      ),
      Text(
        'Cloud Cloud',
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    ],
  );
}
