import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'courses.dart';
import 'home.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var _selected = 0;
  final _screens = [const Home(), const Courses()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color(0xffebf4f4),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selected,
          onTap: (select) {
            setState(() {
              _selected = select;
            });
          },
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
            // BottomNavigationBarItem(
            //   icon: Icon(CupertinoIcons.heart),
            //   label: '',
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(CupertinoIcons.person),
            //   label: '',
            // ),
          ],
        ),
        body: _screens[_selected]);
  }
}
