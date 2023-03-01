import 'package:flutter/material.dart';
import 'package:lingonote/data/repositories/database/database_helper.dart';
import 'package:lingonote/managers/pref_mgr.dart';
import 'package:lingonote/screen/edit_note_screen.dart';
import 'package:lingonote/screen/feed_home_screen.dart';
import 'package:lingonote/screen/record_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FeedHomeScreenState> _feedHomeWidgetKey = GlobalKey();
  final double _bottomNavigationBarHeight = 80;
  int _selectedBottomNavIndex = 0;

  late final dynamic pages;

  Future fetchUid() async {
    const uid = 1234567890123456; //for test
    await PrefMgr.prefs.setInt(PrefMgr.uid, uid);
  }

  Future openDatabase() async {
    await DataBaseHelper().openDB();
  }

  void buildPages() {
    pages = [
      FeedHomeScreen(key: _feedHomeWidgetKey),
      const RecordScreen(),
      const RecordScreen(),
      const RecordScreen(),
      const RecordScreen(),
    ];
  }

  @override
  void initState() {
    fetchUid();
    openDatabase();
    buildPages();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedBottomNavIndex],
      floatingActionButton: SizedBox(
        width: 75,
        height: 75,
        child: FloatingActionButton(
          child: const Icon(Icons.create_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EditNoteScreen(),
                fullscreenDialog: true,
                allowSnapshotting: true,
              ),
            ).then((value) {
              _feedHomeWidgetKey.currentState?.fetchNotes();
            });
          },
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
          height: _bottomNavigationBarHeight,
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
            buildNavBarItem(Icons.dynamic_feed_rounded, 0, true),
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
            _selectedBottomNavIndex = index;
          }
        });
      },
      child: Container(
        height: _bottomNavigationBarHeight,
        width: MediaQuery.of(context).size.width / 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: index == 0 ? const Radius.circular(25) : Radius.zero,
            topRight: index == 4 ? const Radius.circular(25) : Radius.zero,
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: enable
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: _selectedBottomNavIndex == index
                        ? Theme.of(context).focusColor
                        : Theme.of(context).disabledColor,
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _selectedBottomNavIndex == index
                          ? Theme.of(context).focusColor
                          : null,
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
