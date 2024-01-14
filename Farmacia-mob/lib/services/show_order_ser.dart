import 'package:farmacia/helper/api.dart';

import 'package:farmacia/models/show_order_mod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class AllOrdersServices {
  Future<List<ShowOrderMod>?> getAllOrder() async {
    List<dynamic> data = [];
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('auth');
    if (Get.locale?.languageCode == 'en') {
      data = await Api().get(
          url: '$baseurl/api/order/showall/en', token: token);
    } else if (Get.locale?.languageCode == 'ar') {
      data = await Api().get(
          url: '$baseurl/api/order/showall/ab', token: token);
    }

    List<ShowOrderMod> orderList = [];
    for (int i = 0; i < data.length; i++) {
      orderList.add(
        ShowOrderMod.fromJson(data[i]),
      );
    }

    return orderList;
  }
}
