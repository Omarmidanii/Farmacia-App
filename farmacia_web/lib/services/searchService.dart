import 'package:farmacia_web/api.dart';
import 'package:farmacia_web/models/medicineModel.dart';
import 'dart:convert';
import 'package:farmacia_web/main.dart';
import 'package:farmacia_web/models/categoriesModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class searchService {

  static int? id;
  Future searchCat(String query) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await Api().post(url: '${baseurl}/api/classification/find',
        body: <String, String>{
          "name": query
        },
        token: token);
    print('response is $response');
    dynamic data = response;

    print('data is $data');
    if (data is List) {
      print("this is list");
      List<categoriesModel> results = data.map((item) => categoriesModel.fromJson(item)).toList();
      return results;
    }
    else if (data is Map<String, dynamic>) {
      print("objectobjectobject");
      List<categoriesModel> results = [];
        results.add(categoriesModel.fromJson(data));
      print('results from 2nd condition: $results');
      return data;
      // If the response is a single object, convert it to a list containing that object
      //     List<CategoriesMod> singleResult = [CategoriesMod.fromJson(data)];
      //   return singleResult;
    } else {
      print("Unexpected response format: $data");
      return data;
    }
  }

  Future<Object> searchforMed(String query, var cate_id) async {
    print(id);
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print("${baseurl}/api/medicine/find/$cate_id");
    print (query);
    var response = await http.post(
      Uri.parse("${baseurl}/api/medicine/find/$cate_id"),
      body: {'commercial_name': query},

      headers: headers,
    );

    print('Response Code: ${response.statusCode}');
    print('Token: $token');

    if (response.statusCode == 200) {
      print("Search Success");
      print(response.body);

      final dynamic data = json.decode(response.body);

      if (data is List) {
        print("this is list");
        List<medMod> results = data.map((item) => medMod.fromJson(item)).toList();
        return results;
      }
      else if (data is Map<String, dynamic>) {
        print("objectobjectobject");
        print('data is $data');
        return data;
      }
      else {
        print("Unexpected response format: $data");
        return data;
      }
    } else if (response.statusCode == 404){
      AlertDialog(title: Text('Ooops!'),content: Text('medicine not found in this category or does not exist!'));
      return [];
    }

    else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      return "";
    }

  }
}