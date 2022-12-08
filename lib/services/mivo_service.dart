import 'dart:convert';

import 'package:monitoring_mobile/models/mivo2.model.dart';
import 'package:monitoring_mobile/models/mivo_model.dart';
import 'package:http/http.dart' as http;

Future<MonRak> getMonRak() async {
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
    throw Exception('Failed to load album');
  }
}

Future<List<DataRak>> getSuplier() async {
  final response = await http.get(Uri.parse(
      'https://638b684b7220b45d228f4fe9.mockapi.io/api/stechoq/monitoring-rak'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var jsonObject = jsonDecode(response.body);
    List<dynamic> listRak = (jsonObject as Map<String, dynamic>)["data"];
    List<DataRak> raks = [];
    for (int i = 1; i < listRak.length; i++) {
      raks.add(DataRak.fromJson(listRak[i]));
    }
    print('raks : $raks');
    return raks;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
