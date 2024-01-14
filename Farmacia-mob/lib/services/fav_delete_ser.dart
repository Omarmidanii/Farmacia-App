import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

Future<void> deleteFavorites(int medicineId) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('auth');
  final response = await http.post(
    Uri.parse('$baseurl/api/favorite/delete'),
    headers: {'Authorization': 'Bearer $token'},
    body: {'medicine_id': medicineId.toString()},
  );
  print(response.body);
  print(response.statusCode);

  if (response.statusCode == 200) {
    print('Medicine deleted favorites successfully');

  } else {
    print('Failed to delete medicin favorites. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
