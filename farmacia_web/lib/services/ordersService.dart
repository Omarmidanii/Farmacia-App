import 'dart:convert';

import 'package:farmacia_web/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api.dart';
import '../models/ordersModel.dart';
import 'package:http/http.dart' as http;
class AllOrdersServices {
  Future<List<ordersModel>?> getAllOrder() async {
    List<dynamic> data = [];
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    data = await Api()
        .get(url: '$baseurl/api/order/showall/en', token: token);

    List<ordersModel> orderList = [];
    for (int i = 0; i < data.length; i++) {
      orderList.add(
        ordersModel.fromJson(data[i]),
      );
    }

    print(orderList);
    return orderList;
  }

  Future set_State(int orderId, int state) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print('token is: $token');
print('I am in SET STATE');
    await Api().post(
        url: '$baseurl/api/order/set_state',
        body: <String, dynamic>{
          "id": orderId.toString(),
          "state": state.toString(),
        },
        token: token);
  }

  Future set_payemnt(int orderId, String paymentState) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print('I am in SET PAYMENT');
    await Api().post(
        url: '$baseurl/api/order/set_payment',
        body: <String, String>{
          "id": orderId.toString(),
          "paid": paymentState,
        },
        token: token);
    print('I am in SSSSSSET PAYMENT');
  }

  Future<Order> getOrderDet(int id) async {
    print('get order fetailkssssdsdfljyeydgfueywbd');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    final response = await http.get(Uri.parse('${baseurl}/api/order/showoneweb/$id'), headers: headers);

    print('response: ${response.statusCode}');

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        Order order = Order.fromJson(jsonResponse);
      print('order: $order');
      return order;
    } else {
      print('sosojoijds');
      print('response: ${response.statusCode}');
      throw Exception('Failed to load order');
    }
  }
}
