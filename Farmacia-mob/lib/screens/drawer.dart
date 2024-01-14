
import 'package:farmacia/screens/languge_screen.dart';
import 'package:farmacia/screens/show_order.dart';
import 'package:farmacia/services/logout.ser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Favorite_Screen.dart';
import 'add_order.dart';
import 'languge_screen.dart';
import 'package:farmacia/screens/med.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      decoration: const BoxDecoration(
       // color: Colors.white,
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(196, 41, 185, 114), //green
                  Color.fromARGB(255, 109, 161, 245), //blue
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '11'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30,
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            title: Text(
              '5'.tr,
              style: const TextStyle(fontSize: 20),
            ),
            leading: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onTap: () {
              Get.to(()=>Fav_Screen());},
          ),

          ListTile(
            title: Text(
              '7'.tr,
              style: const TextStyle(fontSize: 20),
            ),
            leading: const Icon(
              Icons.add_box_outlined,
              color: Colors.purple,
            ),
            onTap: () {
              Get.to(() =>Cart());
            },
          ),
          ListTile(
            title: Text(
              '8'.tr,
              style: const TextStyle(fontSize: 20),
            ),
            leading: const Icon(
              Icons.shopping_cart,
              color: Colors.blueAccent,
            ),
            onTap: () {
              Get.to(() => const ShowOrder());
            },
          ),

          ListTile(
              title: Text(
                '10'.tr,
                style: const TextStyle(fontSize: 20),
              ),
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: Text(
                            '48'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: Text(
                            '49'.tr,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  bool success = await logout();
                                  if (success) {
                                    print('Token deleted successfully');
                                  } else {
                                    print('Failed to delete token');
                                  }
                                },
                                child: Text('50'.tr)),
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("51".tr))
                          ]);
                    });
              }),
        ],
      ),
    ));
  }

}
