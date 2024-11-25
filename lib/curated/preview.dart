import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors.dart';

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> with SingleTickerProviderStateMixin {
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
      backgroundColor: const Color(0xffebf4f4),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: MyColors.gradient2,
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
                // title: const Text('Title Main Desc'),
                // snap: true,
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text('Henry Harvin'),
                  background: Image.network(
                    'https://s1.1zoom.me/prev/514/Scenery_Sunrises_and_sunsets_Sky_Roads_Stones_Rays_513485_600x300.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SliverToBoxAdapter(
                child: Card(
                  child: Column(
                    children: [
                      Text('data'),
                      const SizedBox(height: 300),
                      Text('data'),
                      const SizedBox(height: 300),
                      Text('data'),
                      const SizedBox(height: 300),
                      Text('data'),
                      const SizedBox(height: 300),
                      Text('data'),
                    ],
                  ),
                ),
              )

              // SliverList(
              //   delegate: SliverChildBuilderDelegate(
              //     childCount: 100,
              //     (context, index) {
              //       return Text('data ${index + 1}');
              //     },
              //   ),
              // )
            ],
          ),
          // Column(
          //   children: [
          //     Expanded(
          //         flex: 1,
          //         child: Padding(
          //           padding: EdgeInsets.symmetric(horizontal: 50),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.stretch,
          //             children: [
          //               SizedBox(height: 40),
          //               Text(
          //                 'Welcome to',
          //                 style: TextStyle(fontSize: 30, color: Colors.white),
          //               ),
          //               Text(
          //                 'Henry Harvin',
          //                 style: TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 40,
          //                     color: Colors.white),
          //               ),
          //               // const SizedBox(height: 16),
          //               // searchBar()
          //             ],
          //           ),
          //         )),
          //     Expanded(
          //       flex: 4,
          //       child: Card(
          //         clipBehavior: Clip.antiAlias,
          //         margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          //         elevation: 4,
          //         color: Colors.white,
          //         shape: const RoundedRectangleBorder(
          //           borderRadius:
          //               BorderRadius.vertical(top: Radius.circular(30)),
          //         ),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             TabBar(
          //               padding: const EdgeInsets.symmetric(vertical: 12),
          //               controller: tabController,
          //               dividerHeight: 0,
          //               isScrollable: true,
          //               // indicator: UnderlineTabIndicator(
          //               //   borderRadius: BorderRadius.circular(4),
          //               //   insets: const EdgeInsets.symmetric(vertical: -4),
          //               //   borderSide: const BorderSide(width: 2.25, color: Colors.black )),
          //               indicatorPadding:
          //                   const EdgeInsets.symmetric(vertical: -6),
          //
          //               tabs: const [
          //                 Text('Chapter 1'),
          //                 Text('Chapter 2'),
          //                 Text('data1'),
          //                 Text('data1'),
          //                 Text('data1'),
          //                 Text('data1'),
          //                 Text('data1'),
          //                 Text('data1'),
          //               ],
          //             ),
          //
          //             Expanded(
          //               child: TabBarView(
          //                   controller: tabController,
          //                   children: const [
          //                     Details(),
          //                     Text('data'),
          //                     Text('data'),
          //                     Text('data'),
          //                     Text('data'),
          //                     Text('data'),
          //                     Text('data'),
          //                     Text('data'),
          //                   ]),
          //             ),
          //
          //             //////////////////////////
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
