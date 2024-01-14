import 'dart:convert';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../screens/categories.dart';


var auth;
Future login(String phonenumber, String password) async {
  var response = await http.post(
    Uri.parse("$baseurl/api/login"),
    body: <String, String>{
      "Phonenumber": phonenumber,
      "Password": password,
    },
  );
  //هون بعمل طباعة قبل ما افوت بالشرط
  print("response is ${response.body}");
  print("resopnse is ${response.statusCode}");
  //الشرط
  if (response.statusCode == 200) {
    print("login Success");
    var js = jsonDecode(response.body);
    auth =  json.decode(response.body)['token'];
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('auth', auth);
    print('the toke is $auth');
    var admin = js["user"]["Is_admin"];
    print(admin);
    if (admin == 0) {

      Get.offAll(() => const Categories());
    }
  } else {
    print("Login failed with status code: ${response.statusCode}");
    Get.defaultDialog(
      title: '38'.tr,
      middleText:
    '32'.tr,
      buttonColor: Colors.blueAccent,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }
}