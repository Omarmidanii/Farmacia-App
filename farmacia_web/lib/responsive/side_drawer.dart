import 'package:farmacia_web/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:farmacia_web/login.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(196, 41, 185, 114),
      elevation: 0,
      child: ListView(
        children: [

          DrawerHeader(
              child: ListTile(
                title: const FittedBox(
                  child: Icon(
                    Icons.ac_unit_rounded,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  print('profile');
                },
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const FittedBox(
                child: Icon(
                  Icons.dashboard,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              title: const AutoSizeText(
                'DASHBOARD',
                style: TextStyle(color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
                minFontSize: 14,
                maxLines: 1,
              ),
              onTap: () {

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Dashboard()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const FittedBox(
                child: Icon(
                  Icons.warehouse,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              title: const AutoSizeText(
                'WAREHOUSE',
                style: TextStyle(color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
                minFontSize: 14,
                maxLines: 1,
              ),
              onTap: () {
                print('object');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const FittedBox(
                child: Icon(
                  Icons.logout,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              title: const AutoSizeText(
                'LOG OUT',
                style: TextStyle(color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
                minFontSize: 14,
                maxLines: 1,
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const login()));
              },
            ),
          ),
        ],
      ),
    );
  }
}