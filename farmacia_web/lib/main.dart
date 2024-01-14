import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:farmacia_web/responsive/layout.dart';
import 'package:farmacia_web/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


//Arabic = true, English = false
const bool language = false;
String baseurl = 'http://192.168.173.198:8000';

var appBarColor = const Color.fromARGB(196, 41, 185, 114);

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();

language ? runApp(const Arabic()) : runApp(const English());

await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
await firebaseMessaging.requestPermission(
  alert: true,
  announcement: false,
  badge: true,
  carPlay: false,
  criticalAlert: false,
  provisional: false,
  sound: true,
);
final token = await firebaseMessaging.getToken(
    vapidKey: "BAukzA_yvZv3AM1q22hvW7-0RGZM_Qew27ehONlcHZCLYNHW3KKsJenNa8IVml7ljtAEQB76j5RBsNfH0WuuADk"
);
print("web token is: $token");

}

class Arabic extends StatelessWidget {
  const Arabic({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login()
        );
  }
}
class English extends StatelessWidget {
  const English({super.key});

  // This widget is the root of your application.
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
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body:
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(196, 41, 185, 114),//green
                Color.fromARGB(255, 109, 161, 245),//blue
              ],),
          ),
          child: Center(
            child: Padding(
              //padding only for Desktop screens
              padding: layout.isDesktop(context)
                  ? const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 60)
                  : layout.isTablet(context)? const EdgeInsets.only(left: 15, right: 15, top: 60, bottom: 60): const EdgeInsets.all(0),
              child: AnimatedContainer(
                  duration: const Duration(microseconds: 100),
                  //width of login screen is 1/3 of screen width on Desktop, and 1/2 on tablet and mobile
                  width: layout.isDesktop(context) ? screenWidth / 3 : layout.isTablet(context)? screenWidth /
                      2 : screenWidth,
                  child: const login()),
            ),
          ),
        ),

      ),
      
    );
  }
}