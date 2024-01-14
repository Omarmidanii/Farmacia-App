import 'package:farmacia/local/local.dart';
import 'package:farmacia/local/local_controller.dart';
import 'package:farmacia/screens/login.dart';
import 'package:farmacia/screens/set_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedpref;

String baseurl = 'http://192.168.173.198:8000';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref = await SharedPreferences.getInstance();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(MyLocaleController());
    MyLocaleController controller = Get.put(MyLocaleController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme:Thems.lighttheme,
      locale: controller.initalLang,
      translationsKeys: MyLocale().keys,
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/Farmacia (1).gif'),
        nextScreen:Test_LoginE(),
        splashTransition: SplashTransition.sizeTransition,
        backgroundColor: Colors.white,
        splashIconSize: 400,
      ),
    );
  }
}
class Thems{
  static ThemeData darktheme=ThemeData.dark().copyWith(
      scaffoldBackgroundColor:Colors.grey[800],
      appBarTheme:AppBarTheme(color:Colors.grey[800]),
    iconTheme:IconThemeData(color:Colors.white,size: 30),
    useMaterial3: false,



      );
  static ThemeData lighttheme=ThemeData.light().copyWith(
    scaffoldBackgroundColor:Colors.white,
    appBarTheme:AppBarTheme(color:Colors.white),
    useMaterial3: false,


  );
}



