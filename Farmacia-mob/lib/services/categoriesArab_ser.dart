import 'package:farmacia/helper/api.dart';
import 'package:farmacia/models/categories_mod.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class AllCategoriesArabServices {
  Future<List<CategoriesMod>?> getAllCateogires() async {
    List<dynamic> data = [];
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('auth');

    data = await Api().get(
        url: '$baseurl/api/classification/showall',
        token: token);

    List<CategoriesMod> categoriesList = [];
    for (int i = 0; i < data.length; i++) {
      categoriesList.add(
        CategoriesMod.fromJson(data[i]),
      );
    }

    return categoriesList;
  }
}
