import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import "package:http/http.dart" as http;
import '../main.dart';
import '../screens/login.dart';

String? authToken;
Future Register_f(String username, String phonenumber, String password) async {
  var response = await http.post(
    Uri.parse("$baseurl/api/register"),
    headers: {'Accept': 'application/json'},
    body: <String, String>{
      "username": username,
      "Phonenumber": phonenumber,
      "Password": password,
    },
  );
  //هون بعمل طباعة قبل ما افوت بالشرط
  print("response is${response.body}");
  print("resopnse is ${response.statusCode}");
  if (response.statusCode == 200) {
    print(" Register success");
    Get.to(() => Test_LoginE());
    authToken = json.decode(response.body)['token'];
  } else {
    print("Register Faild");
    Get.defaultDialog(
      title: " Register Faild",
      middleText: " This Phonenumber and Username already exist",
      buttonColor: Colors.blueAccent,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }
}