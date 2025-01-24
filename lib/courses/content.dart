import 'dart:async';

import 'package:flutter/material.dart';
import '../Api.dart';
import '../component.dart';

class Content extends StatefulWidget {
  final dynamic colors, cid, entry, selectedIndex, zoom;

  const Content(
      {super.key,
      required this.colors,
      required this.cid,
      required this.entry,
      required this.selectedIndex,
      required this.zoom});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  bool isLoading = true;

  List<dynamic> list = [];

  var timer;

  @override
  void initState() {
    super.initState();
    init();
    timer = Timer.periodic(const Duration(seconds: 3), (count) {
      init();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void init() async {
    final key = widget.entry['key'].isNotEmpty
        ? widget.entry['key']
        : "${widget.cid}/${widget.entry['title']}.json";

    var res = await Api().load(key);
    list = res.data;
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
                        widget.entry['title'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
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
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: isLoading
                        ? Center(child: CircularProgressIndicator(color: widget.colors[1]))
                        : list.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(40),
                                child: Image.asset(
                                  'assets/coming_soon.png',
                                  color: widget.colors[1],
                                ),
                              )
                            : DefaultTabController(
                                initialIndex: list.length > widget.selectedIndex
                                    ? widget.selectedIndex
                                    : list.length - 1,
                                length: list.length, //widget.course.length,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TabBar(
                                      // padding: const EdgeInsets.only(bottom: 4),
                                      // indicatorPadding: const EdgeInsets.symmetric(vertical: -6),
                                      labelPadding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
                                      dividerHeight: 0,
                                      indicatorColor: widget.colors[1],
                                      isScrollable: true,

                                      tabs: [
                                        // for (var item in widget.entry.value)
                                        for (var i = 0; i < list.length; i++)
                                          Text(widget.entry['lessons'].length > i
                                              ? widget.entry['lessons'][i]
                                              : "Undefined")
                                      ],
                                    ),

                                    Expanded(
                                      child: TabBarView(
                                        children: [
                                          for (var doc in list)
                                            contentList(
                                                doc,
                                                widget.entry['key'].isNotEmpty
                                                    ? widget.entry['key'].toString().split('/')[0]
                                                    : widget.cid,
                                                // widget.entry['title'].toString().replaceAll(" ", ""),
                                                widget.zoom)
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

Widget contentList(list, cid, zoom) {
  return ListView.builder(
    padding: const EdgeInsets.fromLTRB(8, 8, 8, 30),
    itemCount: list.length,
    itemBuilder: (BuildContext context, int index) {
      final topic = list[index];
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index != 0) const Divider(),
            if (topic['head'] != null) head(topic['head']),
            if (topic['image'] != null) image(cid, topic['image'], zoom),
            if (topic['title'] != null) title(topic['title']),
            if (topic['desc'] != null) desc(topic['desc'], context),
            if (topic['ans'] != null) Answer(answer: topic['ans'])
          ],
        ),
      );
    },
  );
}
