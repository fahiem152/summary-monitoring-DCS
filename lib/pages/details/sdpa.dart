import 'dart:convert';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SumDailyProdAchiev extends StatefulWidget {
  const SumDailyProdAchiev({Key? key}) : super(key: key);

  @override
  State<SumDailyProdAchiev> createState() => _SumDailyProdAchievState();
}

class _SumDailyProdAchievState extends State<SumDailyProdAchiev> {
  bool loading = true;
  List percentageList = [];

  void getData() async {
    var response = await http.get(
      Uri.parse(
        "https://638c9d1beafd555746aa50c9.mockapi.io/percentage",
      ),
    );
    var data = json.decode(response.body)['data'];
    setState(() {
      // stock = stockModelFromJson(data);
      percentageList = data;
      loading = false;
    });
  }

  void initState() {
    super.initState();
    getData();
  }
  void _showDatePlicker() {
    showDateRangePicker(
      context: context, 
      firstDate: DateTime.now(), 
      lastDate: DateTime(2025),
  );}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            padding: EdgeInsets.zero,
            width: 300, //ukuran atas 1
            height: 30,
            child: Row(
              children: [
                Text(
                  "Plan vs Actual",
                ),
                Container(
                  child: MaterialButton(onPressed: _showDatePlicker,
                    child: Text("Tekan disini", style: TextStyle(color: Colors.black)),
                    
                  ),
                  margin: EdgeInsets.fromLTRB(100, 5, 5, 5),
                  width: 100,
                  height: 15,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(1, 1))
                      ]),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(1, 1))
                ]),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 3, 50, 20),
            width: 300,
            height: 300,
            child: Row(
              children: <Widget>[
                Row(
                  children: [
                    Center(
                        child: Container(
                      height: 280,
                      width: 280,
                      child: DChartBar(
                        data: [
                          {
                            'id': 'Bar',
                            'data': [
                              {'domain': '2020', 'measure': 600},
                              {'domain': '2021', 'measure': 400},
                            ],
                          },
                        ],
                        domainLabelPaddingToAxisLine: 16,
                        axisLineTick: 2,
                        axisLinePointTick: 2,
                        axisLinePointWidth: 10,
                        axisLineColor: Colors.black,
                        measureLabelPaddingToAxisLine: 16,
                        barColor: (barData, index, id) => Colors.blue,
                        showBarValue: true,
                      ),
                    )),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(1, 1))
                ]),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              padding: EdgeInsets.zero,
              width: 300, //ukuran atas 2
              height: 30,

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: Offset(1, 1))
                  ]),
            ),
          ),
          Container(
            width: 300,
            height: 300,
            child: Center(
                child: Container(
              height: 280,
              width: 280,
              child: Expanded(
                child: DChartPie(
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
                  donutWidth: 30,
                  labelColor: Colors.white,
                ),
              ),
            )),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(1, 1))
                ]),
          ),
        ],
      ),
    );
  }
}
