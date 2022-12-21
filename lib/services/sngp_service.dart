import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:monitoring_mobile/helper/user_info.dart';
import 'package:monitoring_mobile/models/stock_ng_model.dart';
import 'package:http/http.dart' as http;

class ServiceSngp {
  static const _baseUrl =
      'https://97d8-103-105-27-82.ap.ngrok.io/api/summary/ng';
  static Future<List<StockNGModel>> getDataSngp({required String date}) async {
    String token = await getToken();
    // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmlzcCI6ImFkbWluIiwicm9sZV9pZCI6MSwiaWF0IjoxNjcxNjM4ODk3LCJleHAiOjE2NzE2Njc2OTd9.KRzWWvHTJPJJ39o-mW3hQQp-eokbv3Itx5utlTPxHLE";
    final response = await http.get(
      Uri.parse(_baseUrl + '/date/' + date),
      headers: {
        HttpHeaders.contentTypeHeader: 'aplication/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonObject = jsonDecode(response.body);
      List data = (jsonObject as Map<String, dynamic>)["list"];
      List<StockNGModel> dataSngp = [];
      dataSngp = stockModelNGFromJson(data);

      return dataSngp;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load DataSngp');
    }
  }
}
