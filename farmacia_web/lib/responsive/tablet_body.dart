import 'package:flutter/material.dart';
import 'package:farmacia_web/responsive/side_drawer.dart';

class TabletLayout extends StatefulWidget {
  const TabletLayout({Key? key}) : super(key: key);

  @override
  State<TabletLayout> createState() => _TabletLayoutState();
}

class _TabletLayoutState extends State<TabletLayout> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        drawer: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: screenWidth / 3,
          child: const SideDrawer(),
        ),
      ),
    );
  }
}
