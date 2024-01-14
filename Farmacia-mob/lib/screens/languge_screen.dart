import 'package:farmacia/local/local_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class lang_Screen extends StatelessWidget {
  const lang_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    MyLocaleController controllerlang = Get.find();
    return Scaffold(
     //   backgroundColor: Colors.white,
        appBar: AppBar(
         // backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            Container(
                width: double.infinity,
               // color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text(
                        '4'.tr,
                        style: const TextStyle(
                          fontSize: 30.0,
                          color: Color.fromARGB(255, 84, 141, 218), //blue
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                          decorationThickness: 0.3,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 90.0,
                    ),
                    Container(
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(196, 73, 185, 125),
                                Color.fromARGB(255, 84, 141, 218), //blue
                              ],
                            )),
                        child: MaterialButton(
                          onPressed: () {
                            controllerlang.changLang('en');
                          },
                          child: Text(
                            "3".tr,
                            style: const TextStyle(
                            //  letterSpacing: 4,
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Container(
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(196, 73, 185, 125), //green
                                Color.fromARGB(255, 109, 163, 245), //blue
                              ],
                            )),
                        child: MaterialButton(
                          onPressed: () {
                            controllerlang.changLang('ar');
                          },
                          child: Text(
                            "2".tr,

                            style: const TextStyle(
                            //  letterSpacing:4,
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                )),
             Padding(
              padding: EdgeInsets.only(top: 410),
              child: SizedBox(
                width: double.infinity,
                child: Image.asset('assets/images/language.png'),
              ),
            ),
          ],
        ));
  }
}
