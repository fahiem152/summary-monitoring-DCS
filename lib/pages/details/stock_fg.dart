import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:monitoring_mobile/constan.dart';
import '../../models/stock_fg_model.dart';
import '../../theme.dart';

class StockFG extends StatefulWidget {
  const StockFG({Key? key}) : super(key: key);

  @override
  State<StockFG> createState() => _StockFGState();
}

class _StockFGState extends State<StockFG> {
  List<StockFGModel> stock = [];
  bool loading = true;

  void getData() async {
    var response = await http.get(
      Uri.parse(
        baseURL + "/api/stechoq/stock-fg",
      ),
    );
    List data = json.decode(response.body)['data'];
    print(json.decode(response.body)['data']);

    setState(() {
      //memasukan data json ke dalam model
      stock = stockModelFromJson(data);
      loading = false;
    });
  }

  List<charts.Series<StockFGModel, String>> _createSampleData() {
    return [
      //charts.Series memiliki 4 paramter wajib
      charts.Series<StockFGModel, String>(
        data: stock,
        id: 'id',
        seriesColor: charts.ColorUtil.fromDartColor(primaryColor),
        domainFn: (StockFGModel stockFGModel, _) => stockFGModel.name,
        measureFn: (StockFGModel stockFGModel, _) => stockFGModel.value,
      )
    ];
  }

  @override
  void initState() {
    super.initState();
    getData();
    // fungsiGetStockOpname();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Stock Opname Finish Good",
          style: blackTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 18,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xff4B556B),
        ),
      ),
      body: Center(
        child: Container(
          height: 400,
          padding: const EdgeInsets.all(15),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  const Text(
                    "Stock Opname Finish Good",
                  ),
                  Expanded(
                    child: charts.BarChart(_createSampleData(),
                        animate: true,
                        domainAxis: const charts.OrdinalAxisSpec(
                          renderSpec: charts.SmallTickRendererSpec(
                            // Rotation Here,
                            labelRotation: -90,
                            labelAnchor: charts.TickLabelAnchor.before,
                            labelOffsetFromTickPx: -5,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
