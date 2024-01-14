import 'package:farmacia/helper/api.dart';
import 'package:farmacia/models/med_profile_mod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class MedProfile {
  Future<MedModProfile> getDetailsForMed(int id) async {
    List<dynamic> data;

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('auth');

    data = await Api().get(
        url: '$baseurl/api/medicine/show/$id', token: token);
       MedModProfile bc;

    bc = MedModProfile.fromJson(data[0]);
    return bc;
  }
}
