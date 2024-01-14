import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:farmacia/helper/api.dart';
import 'package:farmacia/models/all_med_mod.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../models/test.dart';

abstract class CartController extends GetxController {
  void getMedication();
  void createOrder();
  List<Med> convertCartModelListToJson();
}

class CartControllerImp extends CartController {
  late List<all_med_model> listMedication;
  late Map<String, dynamic> jsonMap;
  late List<TextEditingController> listTextController;
  @override
  void createOrder() async {
    try {
     List<Med> test= convertCartModelListToJson();
      print('hhhh ${testToJson(new Test(meds: test))}');
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('auth');
      final headers = {
        'Accept': 'application/json',
        'Accept-Encoding': 'gzip, deflate, br',
        'Content-Type': 'application/json',
      };
      headers['Authorization'] = 'Bearer $token';
      var body =jsonEncode(jsonMap) ;
      print(' body is $body');
      var response = await http.post(
        Uri.parse('$baseurl/api/order/create'),
        body: testToJson(new Test(meds: test)),
        headers: headers
      );
      print("the token ${token}");
      print(" the error is ${response.body}");
      print(" the status is ${response.statusCode}");
      if (response.statusCode == 200) {
        print('order is send');
        Get.defaultDialog(
          title: "58".tr,
          middleText: "56".tr,
          buttonColor:Colors.blueAccent,
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          },
          barrierDismissible: false,
        );
        for (int i = 0; i < listTextController.length; i++) {
          listTextController[i].clear();
        }
      } else {
        Get.defaultDialog(
          title: "38".tr,
          middleText: "57".tr,
          buttonColor: const Color.fromARGB(255, 118, 168, 255),
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          },
          barrierDismissible: false,
        );
        print("ther is proplem with ${response.statusCode}with ${jsonDecode(response.body)}");
      }
      update();
    } catch (e) {
      print('hoiiiiiiiiii');
      print('Error: $e');
    }
  }

  @override
  Future<List<all_med_model>> getMedication() async {
    List<dynamic> data = [];
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('auth');
    data = await Api().get(
        url: '$baseurl/api/medicine/showall', token: token);

    for (int i = 0; i < data.length; i++) {
      listMedication.add(all_med_model(name: data[i]['name'], id: data[i]['id']));
      listTextController.add(TextEditingController());
    }

    print('the medication is:');

    print(listMedication.length);

    update();
    return listMedication;
  }

  @override
  List<Med> convertCartModelListToJson() {
    List<Med>test=[];
    jsonMap = {"meds": []};
    for (int i = 0; i < listTextController.length; i++) {

      if (listTextController[i].text.isNotEmpty) {
        test.add(new Med(medId: listMedication[i].id.toString(), quantity:  listTextController[i].text));

             }
    }
    print('convertCartModelListToJson $jsonMap');
    return test;
  }

  @override
  void onInit() {
    listTextController=[] ;
    listMedication = [];
    getMedication();
    super.onInit();
  }
}
