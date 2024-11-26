import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:learning_app/colors.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: MyColors.gradient1),
          ),
        ),
        /////////////////
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // SizedBox(height: 10),
                  Text('Welcome to', style: TextStyle(fontSize: 30)),
                  // const SizedBox(height: 16),
                  // searchBar()
                ],
              ),
            ),
            ////////////////////////////////
            Expanded(
              child: Card(
                  margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: MasonryGridView.count(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 9,
                    ),
                    crossAxisCount: 2,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient:
                                LinearGradient(colors: MyColors.gradient1),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          // Varying heights for tiles
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'UI/UX Designer ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Text(
                                'Product Designer Fellowship',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ],
    );
  }
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