import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:monitoring_mobile/constan.dart';
import 'package:monitoring_mobile/helper/user_info.dart';
import 'package:monitoring_mobile/models/stock_ng_model.dart';
import 'package:http/http.dart' as http;
import 'package:monitoring_mobile/services/sngp_service.dart';
import 'package:monitoring_mobile/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class SumNGPart extends StatefulWidget {
  const SumNGPart({Key? key}) : super(key: key);

  @override
  State<SumNGPart> createState() => _SumNGPartState();
}

class _SumNGPartState extends State<SumNGPart> {
  TextEditingController tanggal = TextEditingController();
  final String datenow = DateFormat('yyyy-MM-dd').format(DateTime.now());

  List<Color> colors = [
    blueColor,
    purpleColor,
    pinkColor,
    Colors.redAccent,
    Colors.amberAccent,
    Colors.greenAccent,
  ];
  late List<StockNGModel> _dataSngp;
  bool loading = true;

  @override
  void initState() {
    super.initState();

    // tanggal.text = datenow;
    _dataSngp = [];
    _getDataSngp();
  }

  _getDataSngp() async {
    String token = await getToken();
    // String token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmlzcCI6ImFkbWluIiwicm9sZV9pZCI6MSwiaWF0IjoxNjcxNjM4ODk3LCJleHAiOjE2NzE2Njc2OTd9.KRzWWvHTJPJJ39o-mW3hQQp-eokbv3Itx5utlTPxHLE";
    _dataSngp = await ServiceSngp.getDataSngp(date: tanggal.text);
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
    print(_dataSngp);
  }

  List<ChartSeries<StockNGModel, String>> _dataChart() {
    return [
      StackedColumnSeries<StockNGModel, String>(
        dataSource: _dataSngp,
        color: blueColor,
        xValueMapper: (StockNGModel ch, _) => ch.part_name,
        yValueMapper: (StockNGModel ch, _) =>
            (ch.qty_ng.length <= 0) ? 0 : ch.qty_ng[0].total,
      ),
      StackedColumnSeries<StockNGModel, String>(
        dataSource: _dataSngp,
        color: purpleColor,
        xValueMapper: (StockNGModel ch, _) => ch.part_name,
        yValueMapper: (StockNGModel ch, _) =>
            (ch.qty_ng.length <= 1) ? 0 : ch.qty_ng[1].total,
      ),
      StackedColumnSeries<StockNGModel, String>(
        dataSource: _dataSngp,
        color: pinkColor,
        xValueMapper: (StockNGModel ch, _) => ch.part_name,
        yValueMapper: (StockNGModel ch, _) =>
            (ch.qty_ng.length <= 2) ? 0 : ch.qty_ng[2].total,
      ),
      StackedColumnSeries<StockNGModel, String>(
        dataSource: _dataSngp,
        color: Colors.redAccent,
        xValueMapper: (StockNGModel ch, _) => ch.part_name,
        yValueMapper: (StockNGModel ch, _) =>
            (ch.qty_ng.length <= 3) ? 0 : ch.qty_ng[3].total,
      ),
      StackedColumnSeries<StockNGModel, String>(
        dataSource: _dataSngp,
        color: Colors.amberAccent,
        xValueMapper: (StockNGModel ch, _) => ch.part_name,
        yValueMapper: (StockNGModel ch, _) =>
            (ch.qty_ng.length <= 4) ? 0 : ch.qty_ng[4].total,
      ),
      StackedColumnSeries<StockNGModel, String>(
        dataSource: _dataSngp,
        color: Colors.greenAccent,
        xValueMapper: (StockNGModel ch, _) => ch.part_name,
        yValueMapper: (StockNGModel ch, _) =>
            (ch.qty_ng.length <= 5) ? 0 : ch.qty_ng[5].total,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Widget getChartStackedSummaryNG() {
      return SfCartesianChart(
        plotAreaBackgroundColor: whiteColor,
        plotAreaBorderColor: white2Color,
        primaryXAxis: CategoryAxis(
          labelStyle: TextStyle(color: black7Color, fontSize: 8),
          labelRotation: _dataSngp.length <= 4 ? 0 : 90,
          isVisible: true,
          isInversed: false,
          plotOffset: 0,
          axisLine: AxisLine(
            color: white2Color,
          ),
        ),
        series: _dataChart(),
      );
    }

    Widget getTableSummaryNG() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: white3Color,
            ),
          ),
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
                      'Part Name',
                      style: textOpenSans.copyWith(
                        fontSize: 13,
                        fontWeight: regular,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Part Number',
                      style: textOpenSans.copyWith(
                        fontSize: 13,
                        fontWeight: regular,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Scarp NG',
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
                  DataColumn(
                    label: Text(
                      'Total Quantity NG',
                      style: textOpenSans.copyWith(
                        fontSize: 13,
                        fontWeight: regular,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ],
                rows: _dataSngp
                    .map(
                      (data) => DataRow(
                        cells: [
                          DataCell(
                            Center(
                              child: Text(
                                data.part_name,
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
                              child: Text(
                                data.part_number,
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
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: data.qty_ng
                                      .map(
                                        (e) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4,
                                          ),
                                          child: Text(
                                            e.name,
                                            style: textOpenSans.copyWith(
                                              fontSize: 15,
                                              fontWeight: bold,
                                              color:
                                                  colors.map((e) => e).toList()[
                                                      data.qty_ng.indexOf(e)],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: data.qty_ng
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4,
                                            ),
                                            child: Text(
                                              e.total.toString(),
                                              style: textOpenSans.copyWith(
                                                fontSize: 15,
                                                fontWeight: regular,
                                                color: black5Color,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: Text(
                                data.total.toString(),
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
                        'All Total',
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
                    child: Center(
                      child: Text(
                        _dataSngp.length == 0
                            ? '0'
                            : _dataSngp
                                .map((e) => e.total.toInt())
                                .reduce((value, element) => value + element)
                                .toString(),
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
          margin: EdgeInsets.all(
            defaultMargin,
          ),
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
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate2 = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate2 != null) {
                          String formattedDate2 =
                              DateFormat('yyyy-MM-dd').format(pickedDate2);

                          print(formattedDate2);
                          setState(
                            () {
                              tanggal.text = formattedDate2;
                              _getDataSngp();
                            },
                          );
                        } else {
                          print('Date is not selected');
                        }
                      },
                      child: Container(
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
                              tanggal.text == '' ? 'yyyy-mm-dd' : tanggal.text,
                              style: textOpenSans.copyWith(
                                fontSize: 12,
                                fontWeight: regular,
                                color: blackColor,
                              ),
                            ),
                            Icon(
                              Icons.expand_more,
                              size: 20,
                              color: black3Color,
                            )
                          ],
                        ),
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
              _dataSngp.length == 0
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.all(defaultMargin),
                        child: Text("Data pada tanggal ini kosong"),
                      ),
                    )
                  : getChartStackedSummaryNG(),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(
            defaultMargin,
          ),
          decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: blackColor.withOpacity(
                  0.5,
                ),
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
                  'Table No Good Part',
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
              _dataSngp.length == 0
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.all(defaultMargin),
                        child: Text("Data pada tanggal ini kosong"),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: getTableSummaryNG(),
                    ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        )
      ],
    );
  }
}
