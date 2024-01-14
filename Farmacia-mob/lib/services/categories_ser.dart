import 'package:farmacia/helper/api.dart';
import 'package:farmacia/models/categories_mod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class AllCategoriesServices {
  Future<List<CategoriesMod>?> getAllCateogires() async {
    Map<String, dynamic> data = {};
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('auth');

    data = await Api()
        .get(url: '$baseurl/api/medicine/index', token: token);
    List<CategoriesMod> categoriesList = [];
    for (int i = 0; i < data['Classifications'].length; i++) {
      categoriesList.add(
        CategoriesMod.fromJson(data['Classifications'][i]),
      );
    }

    return categoriesList;
  }
}
