import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:monitoring_mobile/constan.dart';
import 'package:monitoring_mobile/models/pfgivo_model.dart';

class ServicePfgivo {
  static const _baseUrl = baseURL + '/api/production/inout';

  static Future<List<DataPfgivo>> getData(String token,
      {required String date}) async {
    final response = await http.get(
      Uri.parse(_baseUrl + '?date=$date'),
      headers: {
        HttpHeaders.contentTypeHeader: 'aplication/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonObject = jsonDecode(response.body);
      List data = (jsonObject as Map<String, dynamic>)["list"];
      List<DataPfgivo> lisData = [];
      lisData = pfgivoModelFromJson(data);
      return lisData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load listData');
    }
  }

  static Future<List<DataPfgivo>> getHistory(String token) async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        HttpHeaders.contentTypeHeader: 'aplication/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonObject = jsonDecode(response.body);
      List data = (jsonObject as Map<String, dynamic>)["list"]["data"];
      List<DataPfgivo> lisData = [];
      lisData = pfgivoModelFromJson(data);
      return lisData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load listData');
    }
  }
}
