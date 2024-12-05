import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../component.dart';
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

  List<QueryDocumentSnapshot> docs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("Curates")
        .doc(widget.course.id)
        .collection("Content")
        .get()
        .then(
      (qs) {
        setState(() {
          docs = qs.docs;
          isLoading = false;
        });
      },
      onError: (e) => print("Error completing: $e"),
    );
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
                  flex: 1,
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
                        padding: const EdgeInsets.fromLTRB(16, 10, 16, 2),
                        child: Text(
                          widget.course['desc'],
                          maxLines: 3,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
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
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                              color: widget.colors[1],
                            ))
                          : docs.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(40),
                                  child: Image.asset(
                                    'assets/coming_soon.png',
                                    color: widget.colors[1],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: docs.length,
                                  padding: const EdgeInsets.all(8),
                                  itemBuilder: (context, index) {
                                    final entries = (docs[index].data()
                                            as Map<String, dynamic>)
                                        .entries
                                        .toList();
                                    entries.sort((a, b) => a.value['show']
                                        .compareTo(b.value['show']));

                                    return Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      margin: const EdgeInsets.all(4),
                                      // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                      child: ExpansionTile(
                                        shape: const RoundedRectangleBorder(),
                                        collapsedShape:
                                            const RoundedRectangleBorder(),
                                        title: Text(docs[index].id),

                                        expandedCrossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        // expandedAlignment: Alignment.centerLeft,
                                        // childrenPadding: const EdgeInsets.only(
                                        //     bottom: 10, left: 30, right: 10),

                                        children:
                                            entries.asMap().entries.map((data) {
                                          // entries.map((data) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Content(
                                                      colors: widget.colors,
                                                      chapter : docs[index].id,
                                                      content: entries,
                                                      index: data.key,
                                                      zoom: widget.course['zoom']),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                vertical: 2,
                                              ),
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      40, 6, 10, 6),
                                              child: Text(
                                                data.value.value['title'],
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        // children: docs[index].data(),
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
