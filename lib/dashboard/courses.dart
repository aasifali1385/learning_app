import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning_app/colors.dart';
import 'package:learning_app/component.dart';
import '../courses/details.dart';

class Courses extends StatefulWidget {
  final String? title, desc;

  const Courses({super.key, this.title, this.desc});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  var courses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    final db = FirebaseFirestore.instance;

    db
        .collection('Curates')
        .where('category', arrayContains: widget.title)
        .get()
        .then((coll) {
      setState(() {
        courses = coll.docs;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 300,
            decoration: const BoxDecoration(
              gradient: MyColors.gradient9,
            ),
          ),
          /////////////////
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: widget.title == null ? 20 : 10),
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          if (widget.title != null)
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: IconButton.styleFrom(
                                backgroundColor: const Color(0x33FFFFFF),
                              ),
                              icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                              ),
                            ),
                          const SizedBox(width: 10),
                          Text(
                            widget.title ?? "Learniverse Courses",
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            widget.title != null ? 16 : 20, 4, 14, 4),
                        child: Text(
                            widget.desc ??
                                "Transform your curiosity into expertise with Learniverse; where every course is a gateway to new opportunities!",
                            // textAlign: TextAlign.center,
                            // overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                                color: Colors.white, fontSize: 16)
                            // const TextStyle(
                            //   color: Colors.white,
                            // fontSize: 16,
                            // ),

                            ),
                      )
                    ],
                  ),
                ),
                ////////////////////////////////
                Expanded(
                  flex: 4,
                  child: Card(
                      margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      elevation: 4,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xff0165C7),
                              ),
                            )
                          : courses.isEmpty
                              ? Image.asset('assets/empty.jpg')
                              : MasonryGridView.count(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 9,
                                  ),
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 2,
                                  itemCount: courses.length,
                                  itemBuilder: (context, index) {
                                    List<Color> backColors = [];
                                    for (var code in courses[index]['colors']) {
                                      backColors.add(
                                          Color(int.parse(code, radix: 16)));
                                    }
                                    return Card(
                                      elevation: 4,
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: backColors),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 10),
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Details(
                                                            colors: backColors,
                                                            course:
                                                                courses[index]),
                                                  ),
                                                );
                                              },
                                              child: courseListItem(
                                                  courses[index]))),
                                    );
                                  },
                                )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
