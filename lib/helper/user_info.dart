import 'package:shared_preferences/shared_preferences.dart';

//get token
Future<String> getToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString('token') ?? '';
}

//get role
Future<String> getrole() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString('role') ?? '';
}

//get email
Future<String> getEmail() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString('email') ?? '';
}

//logout
Future<bool> logout() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.remove('token');
}