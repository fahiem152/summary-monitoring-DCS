import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:monitoring_mobile/constan.dart';
import 'package:monitoring_mobile/models/stock_ng_model.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class SumNGPart extends StatelessWidget {
  const SumNGPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0xff404040).withOpacity(0.5),
                blurRadius: 2,
              )
            ],
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bar Chart Summary NG Part',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(
                          0xff404040,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(
                          0xffECECEC,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 14,
                            color: Color(
                              0xff6E5DE7,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '25/11/2022',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(
                                0xff333333,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.expand_more,
                            size: 20,
                            color: Color(0xff363B3F),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(
                        0xffECECEC,
                      ),
                      width: 4,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
              StackedChartSummaryNG()
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0xff404040).withOpacity(0.5),
                blurRadius: 2,
              )
            ],
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(
                  16,
                ),
                child: Text(
                  'Table No Good Opname',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(
                        0xffECECEC,
                      ),
                      width: 4,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class StackedChartSummaryNG extends StatefulWidget {
  StackedChartSummaryNG({Key? key}) : super(key: key);

  @override
  State<StackedChartSummaryNG> createState() => _StackedChartSummaryNGState();
}

class _StackedChartSummaryNGState extends State<StackedChartSummaryNG> {
  List<StockNGModel> stock = [];
  late StockNGModel stockNG;
  bool loading = true;
  void getDataNG() async {
    var response = await http.get(
      Uri.parse(
        baseURL + "/api/stechoq/summary-ngp",
      ),
    );
    List data = json.decode(response.body);
    print(json.decode(response.body));

    setState(() {
      //memasukan data json ke dalam model
      stock = stockModelNGFromJson(data);
      loading = false;
    });
    print('ini adalah data stock: ${stock.length}');
  }

  final List<ChartData> chartData = [
    ChartData('India', 20, 30, 40, 50),
    ChartData('UK', 20, 50, 40, 20),
    ChartData('Amerika', 10, 20, 30, 50),
    ChartData('China', 30, 20, 50, 10),
    ChartData('Indonesia', 30, 50, 50, 10),
  ];
  @override
  void initState() {
    super.initState();
    getDataNG();
    // fungsiGetStockOpname();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBackgroundColor: Colors.white,
      plotAreaBorderColor: Color(0xffECECEC),
      primaryXAxis: CategoryAxis(
        isVisible: true,
        isInversed: false,
        // desiredIntervals: 1,

        plotOffset: 0,
        axisLine: AxisLine(
          color: Color(
            0xffECECEC,
          ),
        ),
      ),
      series: <ChartSeries>[
        StackedColumnSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData ch, _) => ch.x,
          yValueMapper: (ChartData ch, _) => ch.y1,
        ),
        StackedColumnSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData ch, _) => ch.x,
          yValueMapper: (ChartData ch, _) => ch.y2,
        ),
        StackedColumnSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData ch, _) => ch.x,
          yValueMapper: (ChartData ch, _) => ch.y3,
        ),
        StackedColumnSeries<ChartData, String>(
          color: Colors.amber,
          dataSource: chartData,
          xValueMapper: (ChartData ch, _) => ch.x,
          yValueMapper: (ChartData ch, _) => ch.y4,
        ),
        StackedColumnSeries<ChartData, String>(
          color: Colors.red,
          dataSource: chartData,
          xValueMapper: (ChartData ch, _) => ch.x,
          yValueMapper: (ChartData ch, _) => 50,
        ),
      ],
    );
  }
}

class ChartData {
  final String x;
  final int y1;
  final int y2;
  final int y3;
  final int y4;
  ChartData(
    this.x,
    this.y1,
    this.y2,
    this.y3,
    this.y4,
  );
}
