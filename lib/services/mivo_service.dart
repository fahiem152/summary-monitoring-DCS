import 'dart:convert';
import 'dart:io';

import 'package:monitoring_mobile/models/mivo_model.dart';
import 'package:monitoring_mobile/models/rak_model.dart';
import 'package:http/http.dart' as http;

class ServiceMivo {
  static const _baseUrl = 'http://192.168.1.153:8080/api/mStocks/inout';

  static Future<List<DataMivo>> getDataMivo(token) async {
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
      List<DataMivo> dataMivo = [];
      dataMivo = mivoModelFromJson(data);
      return dataMivo;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load DataMivo');
    }
  }

  static Future<MonRak> getMonRak() async {
    final response = await http.get(Uri.parse(
        'https://638b684b7220b45d228f4fe9.mockapi.io/api/stechoq/monitoring-rak'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("Monrak ${MonRak.fromJson(jsonDecode(response.body))}");
      return MonRak.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load MonRak');
    }
  }

  static Future<List<DataRak>> getSuplier() async {
    final response = await http.get(Uri.parse(
        'https://638b684b7220b45d228f4fe9.mockapi.io/api/stechoq/monitoring-rak'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonObject = jsonDecode(response.body);
      List data = (jsonObject as Map<String, dynamic>)["data"];
      List<DataRak> dataRak = [];
      dataRak = dataRakModelFromJson(data);
      return dataRak;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load dataRak');
    }
  }
}
