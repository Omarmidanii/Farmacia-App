import 'dart:convert';

import 'package:farmacia_web/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api.dart';
import '../models/medicineModel.dart';

class medicineService {
  Future<List<dynamic>?> getAllMedicines() async {
    List<dynamic> data = [];
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print("Token: $token");  // Print the token to check if it's null

    try {
      data = await Api().get(url: '$baseurl/api/medicine/showall', token: token);
      print("Response: $data");  // Print the response to check if the API call is successful
    } catch (e) {
      print("API call failed: $e");
      return null;
    }

    List<dynamic> medicinesList = data;
    print("medicinesList from service:\n\n$medicinesList");
    return medicinesList;
  }


  Future<List<medMod>?> getMedicines(int id) async {
    List<dynamic> data = [];
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print("Token: $token"); // Print the token to check if it's null
    data = await Api().get(
        url: '$baseurl/api/medicine/showmeds/$id',
        token: token);

    if (data.isEmpty) {
      print('its null');
      return null; // Handle empty response
    }

    List<medMod> medicinesList = [];

    print('data med with cat:   $data');
    if (data.isNotEmpty) {
      for (int i = 0; i < data[0].length; i++) {
        medicinesList.add(
          medMod.fromJson(data[0][i]),
        );
      }
    }
    print('medicine list with category: $medicinesList');
    return medicinesList;
  }

  Future<List<medicineModel>?> getMedDetails(int id) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print("Token: $token");  // Print the token to check if it's null

    try {
      final data = await Api().get(url: '$baseurl/api/medicine/show/$id', token: token);
      print("Response: $data");  // Print the response to check if the API call is successful

      if (data is List) {
        List<medicineModel> medicinesList = data.map((item) => medicineModel.fromJson(item)).toList();
        print("medicinesList from service with category:\n\n$medicinesList");
        return medicinesList;
      } else {
        return null;
      }
    } catch (e) {
      print("API call failed: $e");
      return null;
    }
  }

}
