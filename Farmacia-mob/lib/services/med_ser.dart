import 'package:farmacia/helper/api.dart';

import 'package:farmacia/models/med_mod.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class MedForCat {
  Future<List<MedMod>> getAllMedForCat(int id) async {
    List<dynamic> data = [];
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('auth');
    //  id = Med.id;
    data = await Api().get(
        url: '$baseurl/api/medicine/showmeds/$id',
        token: token);

    // ignore: non_constant_identifier_names
    List<MedMod> MedList = [];
    if (data.isNotEmpty) {
      for (int i = 0; i < data[0].length; i++) {
        MedList.add(
          MedMod.fromJson(data[0][i]),
        );
      }
    }

    return MedList;
  }
}
