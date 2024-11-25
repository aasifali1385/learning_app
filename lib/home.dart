import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffebf4f4),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 32,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_grid_2x2),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: '',
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  // begin: Alignment.topCenter,
                  // end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffcee6e8),
                    Color(0xffebf4f4),
                  ]),
            ),
          ),
          Column(
            children: [
              const Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 30),
                        Text(
                          'Welcome to',
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          'Henry Harvin',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40),
                        ),
                        // const SizedBox(height: 16),
                        // searchBar()
                      ],
                    ),
                  )),
              Expanded(
                flex: 4,
                child: Card(
                  margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  elevation: 4,
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
                        child: Text('Curated For You',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19)),
                      ),

                      Expanded(
                        flex: 2,
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            item1(),
                            item1(),
                            item1(),
                          ],
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                        child: Text('Curated By Category',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19)),
                      ),

                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 26),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                item2(),
                                item2(),
                                item2(),
                                item2(),
                              ],
                            ),
                          )),

                      //////////////////////////
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
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
