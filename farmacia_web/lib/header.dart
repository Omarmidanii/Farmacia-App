import 'dart:math';
import 'package:farmacia_web/responsive/layout.dart';
import 'package:farmacia_web/Dashboard.dart';
import 'package:farmacia_web/main.dart';
import 'package:farmacia_web/statsDetails.dart';
import 'package:flutter/material.dart';
import 'package:farmacia_web/Warehouse.dart';

int TabsNumber = 3;

class TabsPane extends StatefulWidget {
  const TabsPane({super.key});

  static _TabsPaneState? of(BuildContext context) {
    final _TabsPaneState? result =
    context.findAncestorStateOfType<_TabsPaneState>();
    if (result != null) {
      return result;
    }
    throw FlutterError('TabsPane.of() called with a context that does not contain a TabsPane.');
  }
  @override
  _TabsPaneState createState() => _TabsPaneState();
  /*@override
  _TabsPaneState createState() {
    _tabsPaneState = _TabsPaneState();
    return _tabsPaneState!;
  }*/
}

class _TabsPaneState extends State<TabsPane> with TickerProviderStateMixin {
  final List<Widget> _tabViews = [
    const Center(
    child: Dashboard(),
  ),
    const Center(
      child: Warehouse(),
    ),];
  final List<Tab> _tabs = [
    const Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.dashboard,
            size: 32,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            'DASHBOARD',
          ),
        ],
      ),
    ),
    const Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warehouse,
            size: 32,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            'WAREHOUSE',
          ),
        ],
      ),
    ),
  ];
  late TabController _tabController;
  bool isDark = false;

@override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(196, 41, 185, 114), //green
                  Color.fromARGB(255, 109, 161, 245), //blue
                ],
              ),
            ),
          ),
          title: const Text('F A R M A C I A'),
          centerTitle: true,
          //title: _isSearching? searchBar: Container(),
          //leadingWidth: screenWidth/5,
          actions: [
            IconButton(onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      backgroundColor:
                      const Color.fromARGB(255, 237, 255, 252),
                      contentPadding: const EdgeInsets.all(50),
                      content: SizedBox(
                          width: layout.isDesktop(context)
                              ? screenWidth * 0.4
                              : layout.isTablet(context)
                              ? screenWidth / 2
                              : screenWidth * 0.8,
                          height: screenHeight * 0.6,
                          child: statsDetails()));
                },
              );
            },
                icon: const Icon(Icons.query_stats)
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const English()));
                },
                icon: const Icon(Icons.exit_to_app),
            ),
          ],
          bottom: TabBar(
            //key: _tabsPaneKey,
            controller: _tabController,
            tabs: _tabs,
            indicatorColor: Colors.white,
          ),
        ),
      body: TabBarView(
        controller: _tabController,
        children: [
          for (int i = 0; i < _tabs.length; i++)
            Builder(
              builder: (BuildContext context) {
                return _tabViews[i];
              },
            ),
        ],
      ),

    );
  }
  Map<String, int> tabTitleCounts = {};

  void addTab(String title, Widget newTabView) {
    String newTitle = title;
    if (tabTitleCounts.containsKey(title)) {
      int count = tabTitleCounts[title]! + 1;
      newTitle = '$title($count)';
      tabTitleCounts[title] = count;
    } else {
      tabTitleCounts[title] = 1;
    }

    Widget closeIcon = IconButton(
      icon: const Icon(Icons.close),
      onPressed: () {
        // Call a method to close the tab here
        // For example:
        closeTab(newTitle);
      },
    );

    final newTab = Tab(
      text: newTitle,
      icon: closeIcon,
    );

    setState(() {
      _tabs.add(newTab);
      _tabViews.add(newTabView); // Add the new TabView

      _tabController = TabController(
          length: _tabs.length, vsync: this, initialIndex: _tabs.length - 1);
      //_tabController.animateTo(_tabs.length - 1);
    });
  }
  void closeTab(String title) {
    setState(() {
      int? tabIndexToRemove;
      for (int i = 0; i < _tabs.length; i++) {
        if (_tabs[i].text == title) {
          tabIndexToRemove = i;
          break;
        }
      }

      if (tabIndexToRemove != null) {
        _tabs.removeAt(tabIndexToRemove);
        _tabViews.removeAt(tabIndexToRemove);

        int newIndex = _tabController.index;
        if (newIndex >= tabIndexToRemove) {
          newIndex--; // Adjust the index if the removed tab was before the current index
        }

        _tabController = TabController(vsync: this, length: _tabs.length, initialIndex: newIndex);
      }
    });
  }

}
