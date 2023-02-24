import 'package:flutter/material.dart';
import 'package:lingonote/screen/feed_home_screen.dart';
import 'package:lingonote/screen/record_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedItemIndex = 0;

  final pages = [
    FeedHomeScreen(),
    const RecordScreen(),
    const RecordScreen(),
    const RecordScreen(),
    const RecordScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedItemIndex],
      floatingActionButton: SizedBox(
        width: 75,
        height: 75,
        child: FloatingActionButton(
          child: const Icon(Icons.create_rounded),
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavBar(),
    );
  }

  Stack buildBottomNavBar() {
    return Stack(
      children: [
        Container(
          height: 90,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                offset: const Offset(2, 2),
                color: Colors.black.withOpacity(0.2),
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            buildNavBarItem(Icons.home_rounded, 0, true),
            buildNavBarItem(Icons.auto_graph_rounded, 1, true),
            buildNavBarItem(Icons.pages, 2, false),
            buildNavBarItem(Icons.format_quote_rounded, 3, true),
            buildNavBarItem(Icons.people_alt_outlined, 4, true),
          ],
        ),
      ],
    );
  }

  Widget buildNavBarItem(IconData icon, int index, bool enable) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (enable) {
            _selectedItemIndex = index;
          }
        });
      },
      child: Container(
        height: 90,
        width: MediaQuery.of(context).size.width / 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: index == 0 ? const Radius.circular(25) : Radius.zero,
            topRight: index == 4 ? const Radius.circular(25) : Radius.zero,
          ),
          color: Colors.white,
        ),
        child: enable
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: _selectedItemIndex == index
                        ? Colors.black
                        : Colors.grey,
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _selectedItemIndex == index
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              )
            : Container(),
      ),
    );
  }
}
