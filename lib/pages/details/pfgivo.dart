import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:monitoring_mobile/models/pfgivo_model.dart';
import 'package:monitoring_mobile/theme.dart';
import 'package:monitoring_mobile/widgets/dashline.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pie_chart/pie_chart.dart';

class ProdFGInVSOut extends StatefulWidget {
  const ProdFGInVSOut({Key? key}) : super(key: key);

  @override
  State<ProdFGInVSOut> createState() => _ProdFGInVSOutState();
}

class _ProdFGInVSOutState extends State<ProdFGInVSOut> {
  DateTime? _dateTime;
  int touchedIndex = -1;
  List<DataPfgivo> dataList = []; // list of api data
  bool loading = true;

  getResponse() async {
    var response = await http.get(
      Uri.parse(
        "https://638b684b7220b45d228f4fe9.mockapi.io/api/stechoq/fg-invsout",
      ),
    );
    List data = json.decode(response.body)['data'];
    print(json.decode(response.body)['data']);
    setState(() {
      //memasukan data json ke dalam model
      dataList = pfgivoModelFromJson(data);
      loading = false;
    });
  }

  // this will make state when app runs
  @override
  void initState() {
    getResponse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id', null);
    // this is a map of data bacause piechart need a map
    Map<String, double> dataMap = {
      "in": dataList.isNotEmpty ? dataList[0].datumIn.toDouble() : 0,
      "out": dataList.isNotEmpty ? dataList[0].out.toDouble() : 0,
      "stock": dataList.isNotEmpty ? dataList[0].stock.toDouble() : 0,
    };
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: loading
                  ? SizedBox(
                      height: 400,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Pie Chart",
                                style: textOpenSans.copyWith(
                                  fontSize: 14,
                                  fontWeight: bold,
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime(2021),
                                    firstDate: DateTime(2021),
                                    lastDate: DateTime.now(),
                                  ).then((date) {
                                    setState(() {
                                      _dateTime = date;
                                      print(_dateTime);
                                    });
                                  });
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  width: 140,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: primaryColor),
                                    color: whiteColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          color: primaryColor,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          _dateTime == null
                                              ? DateFormat("yMd", "id")
                                                  .format(DateTime.now())
                                              : DateFormat("yMd", "id")
                                                  .format(_dateTime!),
                                          style: textOpenSans.copyWith(
                                            fontWeight: regular,
                                          ),
                                        ),
                                        const Icon(
                                          CupertinoIcons.chevron_down,
                                          color: Colors.black87,
                                          size: 17,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const DashLineView(
                          fillRate: 1,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              height: 18,
                            ),
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: PieChart(
                                  dataMap:
                                      dataMap, // this need to be map for piechart
                                  animationDuration:
                                      const Duration(milliseconds: 800),
                                  chartLegendSpacing: 32,
                                  initialAngleInDegree: 0,
                                  chartType: ChartType.disc,
                                  ringStrokeWidth: 32,
                                  legendOptions: const LegendOptions(
                                    showLegendsInRow: false,
                                    legendPosition: LegendPosition.right,
                                    showLegends: true,
                                  ),
                                  chartValuesOptions: const ChartValuesOptions(
                                    showChartValueBackground: true,
                                    showChartValues: true,
                                    showChartValuesOutside: false,
                                    decimalPlaces: 1,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 28,
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
