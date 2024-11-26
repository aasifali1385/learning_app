import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../colors.dart';
import 'content.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    tabController = TabController(length: 8, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 240,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 22),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: MyColors.gradient2),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: IconButton.styleFrom(
                backgroundColor: const Color(0x4DFFFFFF),
              ),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
            ),
          ),
          //////////////////////////
          Column(
            children: [
              const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [],
                    ),
                  )),
              Expanded(
                flex: 4,
                child: Card(
                  clipBehavior: Clip.antiAlias,
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
                      TabBar(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        controller: tabController,
                        dividerHeight: 0,
                        isScrollable: true,
                        // indicator: UnderlineTabIndicator(
                        //   borderRadius: BorderRadius.circular(4),
                        //   insets: const EdgeInsets.symmetric(vertical: -4),
                        //   borderSide: const BorderSide(width: 2.25, color: Colors.black )),
                        indicatorPadding:
                            const EdgeInsets.symmetric(vertical: -6),

                        tabs: const [
                          Text('Chapter 1'),
                          Text('Chapter 2'),
                          Text('data1'),
                          Text('data1'),
                          Text('data1'),
                          Text('data1'),
                          Text('data1'),
                          Text('data1'),
                        ],
                      ),

                      Expanded(
                        child: TabBarView(
                            controller: tabController,
                            children: const [
                              Content(),
                              Text('data'),
                              Text('data'),
                              Text('data'),
                              Text('data'),
                              Text('data'),
                              Text('data'),
                              Text('data'),
                            ]),
                      ),

                      //////////////////////////
                    ],
                  ),
                ),
              ),
            ],
          ),
          //////////////////////////
        ],
      ),
    );
  }

/////////////////////////////
}
