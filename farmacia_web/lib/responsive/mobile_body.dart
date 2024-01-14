import 'package:flutter/material.dart';
import 'package:farmacia_web/responsive/side_drawer.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({Key? key}) : super(key: key);

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        drawer: SideDrawer(),
      ),
    );
  }
  }