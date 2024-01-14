import 'package:farmacia/screens/about_us_page.dart';
import 'package:farmacia/screens/languge_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../main.dart';

class Setting_asmaa extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        
        //  color:Colors.white,
        child: ListView(
          children:[
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: Get.width/2.5,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(196, 41, 185, 114), //green
                          Color.fromARGB(255, 109, 161, 245), //blue
                        ],
                      )),
                ),
                Positioned (top: Get.width/3.5 , child:  Container(
                    padding:const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(100)),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/Settings-icon.png'),
                    )
                ),),
              ],),
            const SizedBox(height: 100,),
            Container(
              padding:const EdgeInsets.symmetric(horizontal: 15),
              child: Card(child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('52'.tr),
                    trailing: IconButton(
                      onPressed:(){
                        if(Get.isDarkMode){
                          Get.changeTheme(Thems.lighttheme);
                        }
                        else{
                          Get.changeTheme(Thems.darktheme);
                        }
                      },
                      icon: Icon(Icons.dark_mode),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('53'.tr),
                    trailing: IconButton(
                      onPressed: (){
                        Get.to(()=>lang_Screen());
                      } ,
                      icon:const Icon(Icons.translate),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    onTap: (){
                      Get.to(()=>AboutScreen());
                    },
                    title: Text('9'.tr),
                    trailing: Icon(Icons.help_center_outlined),
                  ),
                  Divider(),


                ],),),
            ),
          ],),
      ),
    );
  }
}
