import 'dart:convert';
import 'dart:io';

import 'package:monitoring_mobile/constan.dart';
import 'package:monitoring_mobile/models/mivo_model.dart';
import 'package:http/http.dart' as http;

class ServiceMivo {
  static const _baseInOut = baseURL + '/api/mStocks/inout';

  static Future<List<DataMivo>> getDataMivo(token) async {
    final response = await http.get(
      Uri.parse(_baseInOut),
      headers: {
        HttpHeaders.contentTypeHeader: 'aplication/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonObject = jsonDecode(response.body);
      print(jsonObject);
      List data = (jsonObject as Map<String, dynamic>)["list"]["data"];
      List<DataMivo> dataMivo = [];
      dataMivo = mivoModelFromJson(data);
      return dataMivo;
    } else if (response.statusCode == 401) {
      throw Exception('Show dialog $unauthorized');
    } else if (response.statusCode == 404) {
      throw Exception('Show dialog 404 Not Found');
    } else if (response.statusCode == 503) {
      throw Exception('Show dialog for error 503');
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Show dialog for other errors');
    }
  }

  // static Future<List<DayElement>> getDayElement(token) async {
  //   final response = await http.get(
  //     Uri.parse(_baseInOut),
  //     headers: {
  //       HttpHeaders.contentTypeHeader: 'aplication/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     var jsonObject = jsonDecode(response.body);
  //     print(jsonObject);
  //     ListElement dayElement = ListElement.fromJson(jsonObject);
  //     return dayElement.day;
  //   } else if (response.statusCode == 404) {
  //     throw Exception('Show dialog $unauthorized');
  //   } else if (response.statusCode == 404) {
  //     throw Exception('Show dialog 404 Not Found');
  //   } else if (response.statusCode == 503) {
  //     throw Exception('Show dialog for error 503');
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Show dialog for other errors');
  //   }

  // try {} catch (e) {
  //   // If the server did not return a 200 OK response,
  //   // then throw an exception.
  //   throw Exception(e.toString());
  // }

  // if (response.statusCode == 200) {
  //   // If the server did return a 200 OK response,
  //   // then parse the JSON.
  //   var jsonObject = jsonDecode(response.body);
  //   List data = (jsonObject as Map<String, dynamic>)["list"]["day"];
  //   List<DayElement> dataMivo = [];
  //   dataMivo = mivoModelFromJson(data);
  //   print(dataMivo);
  //   return dataMivo;
  // } else {
  //   // If the server did not return a 200 OK response,
  //   // then throw an exception.
  //   throw Exception('Failed to load DataMivo');
  // }
  // }
}
