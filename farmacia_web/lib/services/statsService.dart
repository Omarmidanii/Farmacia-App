import 'dart:convert'; // Import this if you are using dart:convert for JSON parsing
import 'package:farmacia_web/main.dart';
import 'package:farmacia_web/models/statsModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class statsService {
  Future<statsModel> fetchStats() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    final response = await http.get(Uri.parse('${baseurl}/api/report/show6'), headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return statsModel.fromJson(data);
    } else {
      throw Exception('Failed to load pharmacy statistics');
    }
  }

  Future<statsModel> fetchOtherStats() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    final response = await http.get(Uri.parse('${baseurl}/api/report/show30'), headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return statsModel.fromJson(data);
    } else {
      throw Exception('Failed to load pharmacy statistics');
    }
  }
}
