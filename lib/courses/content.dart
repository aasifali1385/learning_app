import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../component.dart';

class Content extends StatefulWidget {
  final dynamic colors, chapter;
  final List<MapEntry<String, dynamic>> content;
  final dynamic zoom, index;

  const Content(
      {super.key,
      required this.colors,
      required this.chapter,
      required this.content,
      required this.index,
      required this.zoom});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  bool isLoading = false;

  // List<QueryDocumentSnapshot> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 22),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: widget.colors),
            ),
          ),
          ///////////////////////////
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 0,
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
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
                        widget.chapter,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    elevation: 4,
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                            color: widget.colors[1],
                          ))
                        : widget.content.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(40),
                                child: Image.asset(
                                  'assets/coming_soon.png',
                                  color: widget.colors[1],
                                ),
                              )
                            : DefaultTabController(
                                initialIndex: widget.index,
                                length: widget
                                    .content.length, //widget.course.length,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TabBar(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      dividerHeight: 0,
                                      indicatorColor: widget.colors[1],
                                      isScrollable: true,
                                      indicatorPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: -6,
                                      ),
                                      tabs: [
                                        for (var doc in widget.content)
                                          Text(doc.value['title'])
                                      ],
                                    ),

                                    Expanded(
                                      child: TabBarView(
                                        children: [
                                          for (var doc in widget.content)
                                            topic(doc.value, widget.zoom)
                                          //contentList(doc, widget.course['zoom']),
                                        ],
                                      ),
                                    ),

                                    //////////////////////////
                                  ],
                                ),
                              ),
                  ),
                ),
              ],
            ),
          ),
          ///////////////////
        ],
      ),
    );
  }

/////////////////////////////
}
