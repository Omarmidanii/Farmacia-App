import 'dart:convert';

import 'package:farmacia/helper/api.dart';
import 'package:farmacia/models/all_med_mod.dart';
import 'package:get/get_connect.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../models/med_mod.dart';
//functionn to get all medicins from api showallmedicins usind a spreate model
//I use all med model to get the name and id for all medicins

class Show_All_Medecinis {
  Future<List<all_med_model>> getAllMedicines() async {
    List<dynamic> data = [];
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('auth');
    data = await Api().get(url:'$baseurl/api/medicine/showall',token: token);

    List<all_med_model> AllMedList = [];
    if (data.isNotEmpty) {
      for (int i = 0; i < data.length; i++) {
        AllMedList.add(
         all_med_model(name:data[i]['name'], id:data[i]['id'] )
        );
      }
    }
    return AllMedList;
  }}


