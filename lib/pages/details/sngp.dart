import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:monitoring_mobile/constan.dart';
import 'package:monitoring_mobile/models/stock_ng_model.dart';
import 'package:http/http.dart' as http;
import 'package:monitoring_mobile/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SumNGPart extends StatefulWidget {
  const SumNGPart({Key? key}) : super(key: key);

  @override
  State<SumNGPart> createState() => _SumNGPartState();
}

class _SumNGPartState extends State<SumNGPart> {
  List<StockNGModel> stock = [];
  // List<ScrabNGModel> scrap = [];

  // late int quantityNG;
  // late StockNGModel stockNG;
  bool loading = true;
  void getDataNG() async {
    var response = await http.get(
      Uri.parse(
        baseURL + "/api/stechoq/summary-ngp",
      ),
    );
    List dataStock = json.decode(response.body);
    print(json.decode(response.body));

    // List dataScrap = json.decode(response.body);
    // print(json.decode(response.body)['scrab_ng']);

    setState(() {
      stock = stockModelNGFromJson(dataStock);
      // scrap = scrabModelNGFromJson(dataScrap);

      loading = false;
    });
  }

  List<ChartSeries<StockNGModel, String>> _dataChart() {
    return [
      StackedColumnSeries<StockNGModel, String>(
        dataSource: stock,
        xValueMapper: (StockNGModel ch, _) => ch.material,
        yValueMapper: (StockNGModel ch, _) => ch.scrab_ng[0].value,
      ),
      StackedColumnSeries<StockNGModel, String>(
        dataSource: stock,
        xValueMapper: (StockNGModel ch, _) => ch.material,
        yValueMapper: (StockNGModel ch, _) => ch.scrab_ng[1].value,
      ),
      StackedColumnSeries<StockNGModel, String>(
        dataSource: stock,
        xValueMapper: (StockNGModel ch, _) => ch.material,
        yValueMapper: (StockNGModel ch, _) => ch.scrab_ng[2].value,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    getDataNG();
  }

  @override
  Widget build(BuildContext context) {
    Widget getChartStackedSummaryNG() {
      return SfCartesianChart(
          plotAreaBackgroundColor: whiteColor,
          plotAreaBorderColor: white2Color,
          primaryXAxis: CategoryAxis(
            isVisible: true,
            isInversed: false,
            plotOffset: 0,
            axisLine: AxisLine(color: white2Color),
          ),
          series: _dataChart()
          // series: <ChartSeries>[
          //   StackedColumnSeries<StockNGModel, String>(
          //     dataSource: stock,
          //     color: blueColor,
          //     xValueMapper: (StockNGModel ch, _) => ch.material,
          //     yValueMapper: (StockNGModel ch, _) => ch.scrab_ng[0].value,
          //   ),
          //   StackedColumnSeries<StockNGModel, String>(
          //     dataSource: stock,
          //     color: purpleColor,
          //     xValueMapper: (StockNGModel ch, _) => ch.material,
          //     yValueMapper: (StockNGModel ch, _) => ch.scrab_ng[1].value,
          //   ),
          //   StackedColumnSeries<StockNGModel, String>(
          //     dataSource: stock,
          //     color: pinkColor,
          //     xValueMapper: (StockNGModel ch, _) => ch.material,
          //     yValueMapper: (StockNGModel ch, _) => ch.scrab_ng[2].value,
          //   ),
          // ],
          );
    }

    Widget getTableSummaryNG() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: white3Color)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DataTable(
                border: TableBorder.all(width: 1, color: white3Color),
                dataRowHeight: 72,
                headingRowHeight: 30,
                headingRowColor: MaterialStateColor.resolveWith(
                  (states) => black4Color,
                ),
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Material',
                      style: textOpenSans.copyWith(
                        fontSize: 13,
                        fontWeight: regular,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Material Number',
                      style: textOpenSans.copyWith(
                        fontSize: 13,
                        fontWeight: regular,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Scrap NG',
                      style: textOpenSans.copyWith(
                        fontSize: 13,
                        fontWeight: regular,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Quantity Scrab',
                      style: textOpenSans.copyWith(
                        fontSize: 13,
                        fontWeight: regular,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Quantity NG',
                      style: textOpenSans.copyWith(
                        fontSize: 13,
                        fontWeight: regular,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ],
                rows: stock
                    .map(
                      (data) => DataRow(
                        cells: [
                          DataCell(
                            Center(
                              child: Text(
                                data.material,
                                style: textOpenSans.copyWith(
                                  fontSize: 15,
                                  fontWeight: regular,
                                  color: black5Color,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: Text(
                                data.material_number,
                                style: textOpenSans.copyWith(
                                  fontSize: 13,
                                  fontWeight: regular,
                                  color: black5Color,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    data.scrab_ng[0].name,
                                    style: textOpenSans.copyWith(
                                      fontSize: 15,
                                      fontWeight: regular,
                                      color: black5Color,
                                    ),
                                  ),
                                  Text(
                                    data.scrab_ng[1].name,
                                    style: textOpenSans.copyWith(
                                      fontSize: 15,
                                      fontWeight: regular,
                                      color: black5Color,
                                    ),
                                  ),
                                  Text(
                                    data.scrab_ng[2].name,
                                    style: textOpenSans.copyWith(
                                      fontSize: 15,
                                      fontWeight: regular,
                                      color: black5Color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    data.scrab_ng[0].value.toString(),
                                    style: textOpenSans.copyWith(
                                      fontSize: 15,
                                      fontWeight: bold,
                                      color: blueColor,
                                    ),
                                  ),
                                  Text(
                                    data.scrab_ng[1].value.toString(),
                                    style: textOpenSans.copyWith(
                                      fontSize: 15,
                                      fontWeight: bold,
                                      color: purpleColor,
                                    ),
                                  ),
                                  Text(
                                    data.scrab_ng[2].value.toString(),
                                    style: textOpenSans.copyWith(
                                      fontSize: 15,
                                      fontWeight: bold,
                                      color: pinkColor,
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: Text(
                                data.getQuantityNG().toString(),
                                style: textOpenSans.copyWith(
                                  fontSize: 15,
                                  fontWeight: regular,
                                  color: black5Color,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 72,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Total',
                        style: textOpenSans.copyWith(
                          fontSize: 15,
                          fontWeight: regular,
                          color: black5Color,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 72,
                    width: MediaQuery.of(context).size.width * 0.315,
                    // decoration: BoxDecoration(
                    //   border: Border(
                    //       left: BorderSide(width: 1, color: white3Color),),
                    // ),
                    child: Center(
                      child: Text(
                        '1000',
                        style: textOpenSans.copyWith(
                          fontSize: 15,
                          fontWeight: regular,
                          color: black5Color,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(defaultMargin),
          decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: blackColor.withOpacity(0.5),
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
                      style: textOpenSans.copyWith(
                        fontSize: 12,
                        fontWeight: bold,
                        color: black2Color,
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
                          color: white2Color),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 16,
                            color: primaryColor,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '25/11/2022',
                            style: textOpenSans.copyWith(
                              fontSize: 12,
                              fontWeight: regular,
                              color: blackColor,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.expand_more,
                            size: 20,
                            color: black3Color,
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
                      color: white2Color,
                      width: 4,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
              getChartStackedSummaryNG(),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 8,
                          width: 20,
                          color: blueColor,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Data 1',
                          style: textInter.copyWith(
                            fontSize: 10,
                            fontWeight: regular,
                            color: black7Color,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 8,
                          width: 20,
                          color: purpleColor,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Data 2',
                          style: textInter.copyWith(
                            fontSize: 10,
                            fontWeight: regular,
                            color: black7Color,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 8,
                          width: 20,
                          color: pinkColor,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Data 3',
                          style: textInter.copyWith(
                            fontSize: 10,
                            fontWeight: regular,
                            color: black7Color,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(defaultMargin),
          decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: blackColor.withOpacity(0.5),
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
                  style: textOpenSans.copyWith(
                    fontSize: 12,
                    fontWeight: bold,
                    color: black6Color,
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
                      color: white2Color,
                      width: 4,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                child: getTableSummaryNG(),
              ),
              SizedBox(
                height: 75,
              )
            ],
          ),
        )
      ],
    );
  }
}
