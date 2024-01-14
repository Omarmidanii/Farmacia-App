import 'package:farmacia/helper/api.dart';
import 'package:farmacia/models/ordar_details_mod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class OrderDetailsServices {
  Future<List<OrdarDetMod>?> getOrderDet(int id) async {
    List<dynamic> data = [];
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('auth');


    data = await Api()
        .get(url: '$baseurl/api/order/showonemob/$id', token: token);

    List<OrdarDetMod> orderDetList = [];
    for (int i = 0; i < data.length; i++) {
      orderDetList.add(
        OrdarDetMod.fromJson(data[i]),
      );
    }

    return orderDetList;
  }
}
