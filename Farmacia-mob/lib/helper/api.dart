import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class Api {
  Future<dynamic> get({required String url, String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'there is proplem with status code ${response.statusCode}');
    }
  }

  Future<dynamic> post(Uri parse,
      {required String url, @required dynamic body, token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response = await http.post(
      Uri.parse(Uri.parse(url) as String),
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      return data; //استطيع ان اكتب return jsonDecode(response.body);
    } else {
      throw Exception(
          'there is proplem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

  Future<dynamic> put(
      {required String url, @required dynamic body, token}) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response = await http.post(
      Uri.parse(Uri.parse(url) as String),
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data; //استطيع ان اكتب return jsonDecode(response.body);
    } else {
      throw Exception(
          'there is proplem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }
}
