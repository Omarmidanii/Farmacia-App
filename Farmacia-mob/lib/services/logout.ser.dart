
import 'package:farmacia/screens/categories.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/login.dart';

Future<bool> logout() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('auth')) {
      await prefs.remove('auth'); // Remove the 'auth' key from SharedPreferences
      if (!prefs.containsKey('auth')) {
        Get.offAll(() => const Test_LoginE()); // Navigate back to the login screen
        return true; // Return true to indicate successful logout
      }
    }
    return false; // Return false if 'auth' key was not found or not removed
  } catch (e) {
    print('Error during logout: $e');
    return false; // Return false if an error occurred during logout
  }
}
//function that cheek if the token exisit move me direct to home page without need to login every time
readtoken() async {
  final prefs=await SharedPreferences.getInstance();
  if(prefs.containsKey('auth'))
    {
      Get.offAll(() => const Categories());
    }
}