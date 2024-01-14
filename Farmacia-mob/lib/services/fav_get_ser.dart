import 'package:farmacia/models/Favorite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/api.dart';
import '../main.dart';

class Show_All_Fav {
  Future<List<Fav_Model>> getAllfav() async {
    List<Map<String, dynamic>> data;
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('auth');

    Map<String, dynamic> response = await Api().get(url: '$baseurl/api/favorite/index', token: token);

    if (response.containsKey('data') && response['data'] is List) {
      // Assign the value of "data" key to the data variable
      data = List<Map<String, dynamic>>.from(response['data']);
    } else {
      // Handle the case where "data" key is missing or not a List
      data = [];
    }

    List<Fav_Model> AllFavMed = [];

    if (data.isNotEmpty) {
      for (int i = 0; i < data.length; i++) {
        AllFavMed.add(
            Fav_Model(name: data[i]['name'], id: data[i]['id'], price: data[i]['price'])
        );
      }
    }

    return AllFavMed;
  }
}
