import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/Api.dart';
import 'content.dart';

class Details extends StatefulWidget {
  final dynamic colors;
  final QueryDocumentSnapshot course;

  const Details({super.key, required this.colors, required this.course});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late TabController tabController;

  // List<QueryDocumentSnapshot> docs = [];
  // bool isLoading = true;
  // List<MapEntry<String, dynamic>> entries = [];
  List<dynamic> entries = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getIndex();
    // if ((widget.course.data() as Map<String, dynamic>).containsKey("chapters")) {
    //   entries = (widget.course['chapters'] as Map<String, dynamic>).entries.toList();
    //   entries.sort((a, b) => a.key.compareTo(b.key));
    // }
  }

  void _getIndex() async {
    final res = await Api().load("${widget.course.id}/index.json");

    if (res.toString().isNotEmpty) entries = res.data;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 300,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                            widget.course['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
                        child: Text(
                          widget.course['desc'],
                          maxLines: 4,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      )
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
                          : entries.isEmpty
                              ? Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(40),
                                  child: Image.asset(
                                    'assets/coming_soon.png',
                                    color: widget.colors[1],
                                  ),
                                )
                              : ListView.builder(
                                  // itemCount: docs.length,
                                  itemCount: entries.length,
                                  padding: const EdgeInsets.all(8),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      margin: const EdgeInsets.all(4),
                                      // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                      child: ExpansionTile(
                                        initiallyExpanded: index == 0,
                                        shape: const RoundedRectangleBorder(),
                                        collapsedShape:
                                            const RoundedRectangleBorder(),
                                        // title: Text(docs[index].id),
                                        // title: Text(entries[index].key),
                                        title: Text(entries[index]['title']),

                                        expandedCrossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        childrenPadding:
                                            const EdgeInsets.only(bottom: 6),

                                        children: (entries[index]['lessons'] as List<dynamic>)
                                            .asMap()
                                            .entries
                                            .map((data) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Content(
                                                      colors: widget.colors,
                                                      cid: widget.course.id,
                                                      entry: entries[index],
                                                      selectedIndex: data.key,
                                                      zoom: widget
                                                          .course['zoom']),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2),
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      40, 6, 10, 6),
                                              child: Text(data.value,
                                                  style: const TextStyle(
                                                      fontSize: 16)),
                                            ),
                                          );
                                        }).toList(),

                                        // children: entries.asMap().entries.map((data) {
                                        //   return InkWell(
                                        //     onTap: () {
                                        // Navigator.push(context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => Content(
                                        //         colors: widget.colors,
                                        //         chapter: docs[index].id,
                                        //         content: entries,
                                        //         index: data.key,
                                        //         zoom: widget.course['zoom']),),);
                                        //     },
                                        //     child: Container(
                                        //       margin:
                                        //           const EdgeInsets.symmetric(
                                        //         vertical: 2,
                                        //       ),
                                        //       padding:
                                        //           const EdgeInsets.fromLTRB(
                                        //               40, 6, 10, 6),
                                        //       child: Text(
                                        //         // data.value.value['title'],
                                        //         "data.value.value['title']",
                                        //         style: const TextStyle(
                                        //           fontSize: 16,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   );
                                        // }).toList(),
                                      ),
                                    );
                                  })

                      // : DefaultTabController(
                      //     length: docs.length,
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         TabBar(
                      //           padding: const EdgeInsets.symmetric(
                      //               vertical: 12),
                      //           dividerHeight: 0,
                      //           indicatorColor: widget.colors[1],
                      //           isScrollable: true,
                      //           indicatorPadding:
                      //               const EdgeInsets.symmetric(
                      //                   vertical: -6),
                      //           tabs: [
                      //             for (var doc in docs) Text(doc.id)
                      //           ],
                      //         ),
                      //
                      //         Expanded(
                      //           child: TabBarView(children: [
                      //             for (var doc in docs)
                      //               contentList(
                      //                   doc, widget.course['zoom']),
                      //           ]),
                      //         ),
                      //         //////////////////////////
                      //       ],
                      //     ),
                      //   ),
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
