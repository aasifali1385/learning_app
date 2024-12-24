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

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final res = await Api().load(
        "${widget.cid}/${widget.entry.key}.json".replaceAll(' ', ''));
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
                        widget.entry.key,
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      dividerHeight: 0,
                                      indicatorColor: widget.colors[1],
                                      isScrollable: true,
                                      indicatorPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: -6,
                                      ),
                                      tabs: [
                                        // for (var item in widget.entry.value)
                                        for (var i = 0; i < list.length; i++)
                                          Text(widget.entry.value.length > i
                                              ? widget.entry.value[i]
                                              : "Undefined")
                                      ],
                                    ),

                                    Expanded(
                                      child: TabBarView(
                                        children: [
                                          for (var doc in list)
                                            contentList(
                                                doc,
                                                widget.cid
                                                    .toString()
                                                    .replaceAll(" ", ""),
                                                widget.entry.key
                                                    .toString()
                                                    .replaceAll(" ", ""),
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
