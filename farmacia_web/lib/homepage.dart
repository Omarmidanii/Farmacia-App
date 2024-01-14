import 'package:flutter/material.dart';
import 'package:farmacia_web/header.dart';

class homepage extends StatelessWidget{
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green, useMaterial3: false),
        home: DefaultTabController(
          length: TabsNumber,
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              child: const TabsPane()),

        )
    );
  }
}