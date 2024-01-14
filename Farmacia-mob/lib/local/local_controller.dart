import 'package:farmacia/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MyLocaleController extends GetxController {
  Locale initalLang = sharedpref?.getString('lang') == 'ar'
      ? const Locale('ar')
      : const Locale('en');
  void changLang(String codelang) {
    Locale locale = Locale(codelang);
    sharedpref?.setString('Lang', codelang);
    Get.updateLocale(locale);
  }
}
