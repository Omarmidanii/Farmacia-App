import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

Future<void> addToFavorites(int medicineId) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth');
  final response = await http.post(
    Uri.parse('$baseurl/api/favorite/add'),
    headers: {'Authorization': 'Bearer $token'},
    body: {'medicine_id': medicineId.toString()},
  );
print(response.body);
print(response.statusCode);

  if (response.statusCode == 200) {
    print('Medicine added to favorites successfully');

  } else {
    print('Failed to add medicine to favorites. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
