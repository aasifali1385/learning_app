import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/colors.dart';
import 'package:learning_app/dashboard/courses.dart';
import '../component.dart';
import '../curated/details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var courses = [];

  @override
  void initState() {
    super.initState();

    final db = FirebaseFirestore.instance;

    db.collection('Curates').get().then((coll) {
      setState(() {
        courses = coll.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          height: 300,
          decoration: const BoxDecoration(gradient: MyColors.gradient2),
        ),
        //////////////////////
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to',
                        style: TextStyle(fontSize: 24),
                      ),
                      Text(
                        'Learniverse',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 36),
                      ),
                    ],
                  ),
                ),
              ),
              ////////////////////////////////////
              Expanded(
                flex: 4,
                child: Card(
                  margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  elevation: 4,
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: coursesForYou(courses)),
                      Expanded(child: coursesByCate(context)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget coursesForYou(courses) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Padding(
        padding: EdgeInsets.fromLTRB(30, 22, 0, 4),
        child: Text(
          'Courses For You',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      Expanded(
        child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            itemBuilder: (context, index) {
              double screenWidth = MediaQuery.of(context).size.width;

              List<Color> backColors = [];
              for (var code in courses[index]['colors']) {
                backColors.add(Color(int.parse(code, radix: 16)));
              }
              return Card(
                elevation: 4,
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  width: screenWidth / 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: backColors,
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(colors: backColors),
                        ),
                      );
                    },
                    child: courseContent(courses[index]),
                  ),
                ),
              );
            }),
      ),
    ],
  );
}

Widget coursesByCate(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.fromLTRB(30, 0, 0, 8),
        child: Text(
          'Courses By Category',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          category(Icons.show_chart_rounded, 'Investing', context),
          category(Icons.candlestick_chart_rounded, 'Trading', context),
          category(Icons.code_rounded, 'Coding', context),
          category(Icons.design_services_rounded, 'Designing', context)
        ],
      ),
    ],
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

Widget category(icon, title, context) {
  return InkWell(
    borderRadius: BorderRadius.circular(10),
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Courses(title:title)));
    },
    child: Column(
      children: [
        Card(
          color: Colors.black,
          elevation: 4,
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              icon,
              size: 38,
              color: Colors.white,
              // shadows: [Shadow(offset: Offset(2, 2), color: Colors.black26)],
            ),
          ),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              // fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4)
      ],
    ),
  );
}
