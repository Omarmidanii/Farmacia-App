import 'package:flutter/material.dart';
import 'package:farmacia_web/responsive/side_drawer.dart';
import 'package:farmacia_web/homepage.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({Key? key}) : super(key: key);

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  bool isDrawerExpanded = false; // Track drawer state
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body:
        Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: screenWidth / 5,
              child: const SideDrawer(), // Adjust width as needed
            ),
            const Expanded(child: homepage())
          ],
        ),

    );
  }
}
