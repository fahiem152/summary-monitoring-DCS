import 'dart:convert';

import 'package:monitoring_mobile/models/api_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constan.dart';

String apiLogin = baseURL + '/api/users/login';

Future<ApiResponse> login(
    {required String email, required String password}) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(apiLogin), headers: {
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    }, body: {
      'email': email,
      'password': password
    });
    switch (response.statusCode) {
      case 200:
        print(response.body);
        // apiResponse.data = UserModel.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['data']['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['data']['errors'];
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


