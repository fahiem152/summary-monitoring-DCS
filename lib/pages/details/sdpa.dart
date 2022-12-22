import 'dart:convert';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:monitoring_mobile/constan.dart';
import 'package:monitoring_mobile/helper/user_info.dart';
import 'package:monitoring_mobile/models/plan_actual_modal.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../theme.dart';

class SumDailyProdAchiev extends StatefulWidget {
  const SumDailyProdAchiev({Key? key}) : super(key: key);

  @override
  State<SumDailyProdAchiev> createState() => _SumDailyProdAchievState();
}

class _SumDailyProdAchievState extends State<SumDailyProdAchiev> {
  TextEditingController tanggal = TextEditingController();
  final String datenow = DateFormat('dd/MM/yyyy').format(DateTime.now());

  bool loading = true;
  List percentageList = [];
  List<Achieved> planned = [];
  List<Achieved> achieved = [];
  List<Achieved> gap = [];

  void getPlan() async {
    String token = await getToken();
    var response = await http.get(
      Uri.parse(
        baseURL + "/api/summary/dpa",
      ),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    var planneds = json.decode(response.body)['list']["data"][0]['planned'];
    var achieveds = json.decode(response.body)['list']["data"][0]['achieved'];
    var gaps = json.decode(response.body)['list']["data"][0]['gap'];
    var percentages =
        json.decode(response.body)['list']["data"][0]['percentage'];
    setState(() {
      print(response);
      planned = achievedModelFromJson(planneds);
      achieved = achievedModelFromJson(achieveds);
      gap = achievedModelFromJson(gaps);
      percentageList = percentages;
      loading = false;
    });
  }

  List<charts.Series<Achieved, String>> _createSampleData() {
    return [
      charts.Series<Achieved, String>(
        id: 'planned',
        domainFn: (Achieved testModel, _) => testModel.name.toString(),
        measureFn: (Achieved testModel, _) => testModel.value,
        seriesColor: charts.ColorUtil.fromDartColor(const Color(0xff376ED9)),
        data: planned,
      ),
      charts.Series<Achieved, String>(
        id: 'gap',
        domainFn: (Achieved testModel, _) => testModel.name.toString(),
        measureFn: (Achieved testModel, _) => testModel.value,
        seriesColor: charts.ColorUtil.fromDartColor(const Color(0xffE94D4D)),
        data: gap,
      ),
      charts.Series<Achieved, String>(
        id: 'achieved',
        domainFn: (Achieved testModel, _) => testModel.name,
        measureFn: (Achieved testModel, _) => testModel.value,
        seriesColor: charts.ColorUtil.fromDartColor(const Color(0xff219653)),
        data: achieved,
      )
    ];
  }

  void initState() {
    super.initState();
    tanggal.text = datenow;
    // getData();
    getPlan();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: 400,
              child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Plan vs Actual",
                            style: textOpenSans.copyWith(
                              color: blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () async {
                              DateTime? pickedDate2 = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));

                              if (pickedDate2 != null) {
                                String formattedDate2 = DateFormat('dd/MM/yyyy')
                                    .format(pickedDate2);
                                print(formattedDate2);

                                setState(() {
                                  tanggal.text = formattedDate2;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 140,
                              decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Center(
                                      child: Icon(
                                        Icons.calendar_month,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      tanggal.text == ''
                                          ? 'dd/mm/yyy'
                                          : tanggal.text,
                                      style: TextStyle(
                                        color: black2Color,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: const Color.fromARGB(188, 158, 158, 158),
                      height: 1,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: charts.BarChart(
                          _createSampleData(),
                          animate: true,
                          barGroupingType: charts.BarGroupingType.stacked,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: 400,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Achievement Percentage",
                        style: textOpenSans.copyWith(
                          color: blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    Container(
                      color: const Color.fromARGB(188, 158, 158, 158),
                      height: 1,
                    ),
                    Expanded(
                        child: Stack(
                      children: [
                        DChartPie(
                          data: percentageList.map((e) {
                            return {'domain': e['name'], 'measure': e['value']};
                          }).toList(),
                          fillColor: ((pieData, index) {
                            switch (index) {
                              case 0:
                                return const Color(0xff219653);
                              case 1:
                                return const Color(0xffE94D4D);
                              default:
                            }
                          }),
                          donutWidth: 60,
                          labelColor: const Color(0xff219653),
                        ),
                        Center(
                          child: Text(
                            percentageList.isNotEmpty
                                ? '${percentageList[0]["value"].toString()} %'
                                : 0.toString(),
                            style: textOpenSans.copyWith(
                              color: blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
