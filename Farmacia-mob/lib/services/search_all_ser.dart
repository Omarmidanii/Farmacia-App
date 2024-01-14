import 'dart:convert';
import 'package:farmacia/helper/api.dart';
import 'package:farmacia/services/register_ser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:farmacia/models/categories_mod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../models/med_mod.dart';
import 'login_ser.dart';

class SearchCatService {
  static int?id;
  //this function is to search to classifaction
  Future<Object> searchCat(String query) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('auth');
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

      var response = await http.post(
        Uri.parse("$baseurl/api/classification/find"),
        body: {'name': query,},
        headers: headers,
      );

      print('Response Code: ${response.statusCode}');
      print('Token: $token');

      if (response.statusCode == 200) {
        print("Search Success");
        print(response.body);

        final dynamic data = json.decode(response.body);
        id=data['id'];
        print("id is $id");
        if (data is List) {
          print("this is list");
          List<CategoriesMod> results = data.map((item) => CategoriesMod.fromJson(item)).toList();
          return results;
        }
        else if (data is Map<String, dynamic>) {
          print("objectobjectobject");
          return data;
          // If the response is a single object, convert it to a list containing that object
     //     List<CategoriesMod> singleResult = [CategoriesMod.fromJson(data)];
       //   return singleResult;
        } else {
          print("Unexpected response format: $data");
          return data;
        }
      }

      else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        return "";
      }

  }

  //this function is to search to medicin with classifacation
  Future<Object> searchforMed(String query,var cate_id) async {
    print(id);
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('auth');
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print("$baseurl/api/medicine/find/$cate_id");
    print (query);
    var response = await http.post(
      Uri.parse("$baseurl/api/medicine/find/$cate_id"),
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
        List<MedMod> results = data.map((item) => MedMod.fromJson(item)).toList();
        return results;
      }
      else if (data is Map<String, dynamic>) {
        print("objectobjectobject");
        return data;
      }
      else {
        print("Unexpected response format: $data");
        return data;
      }
    }

    else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      return "";
    }

  }
}



