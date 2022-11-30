import 'dart:convert';

import 'package:monitoring_mobile/models/api_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:monitoring_mobile/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constan.dart';

String apiLogin = 'https://dummyjson.com/auth/login';

Future<ApiResponse> login(
    {required String username, required String password}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(
      Uri.parse(apiLogin),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {"username": username, "password": password},
      ),
    );  
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['data']['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 400:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWhentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}
