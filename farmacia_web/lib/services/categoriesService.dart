
import 'package:farmacia_web/main.dart';
import 'package:farmacia_web/models/categoriesModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

class AllCategoriesServices {
  Future<List<categoriesModel>?> getAllCategories() async {
    Map<String, dynamic> data = {};
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    data = await Api()
        .get(url: '$baseurl/api/medicine/index', token: token);

    List<categoriesModel> categoriesList = []; //= data.map((category) => categoriesModel.fromJson(category)).toList();
    for (int i = 0; i < data['Classifications'].length; i++) {
      categoriesList.add(
        categoriesModel.fromJson(data['Classifications'][i]),
      );
    }

    print("categoriesList from service:\n\n$categoriesList");
    return categoriesList;
  }
}
