import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:monitoring_mobile/models/mivo_model.dart';
import 'package:monitoring_mobile/models/rak_model.dart';
import 'package:monitoring_mobile/services/mivo_service.dart';
import 'package:monitoring_mobile/theme.dart';
import 'package:monitoring_mobile/widgets/dashline.dart';
import 'package:monitoring_mobile/widgets/fl_chart/indicator.dart';
import 'package:monitoring_mobile/widgets/indicators_widget.dart';
import 'package:monitoring_mobile/widgets/pie_chart_sections.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../helper/user_info.dart';

class MaterialInVSOut extends StatefulWidget {
  const MaterialInVSOut({Key? key}) : super(key: key);

  @override
  State<MaterialInVSOut> createState() => _MaterialInVSOutState();
}

class _MaterialInVSOutState extends State<MaterialInVSOut> {
  int touchedIndex = -1;
  bool loading = true;
  DateTime? _dateTime;
  String slcTypeRak = "racktypem";
  String slcAdressRak = "address1";
  late MonRak _monrak;
  late List<DataMivo> _dataMivo;
  late List<DataRak> _dataRak;
  double size = 22;

  @override
  void initState() {
    _monrak = MonRak(
      status: false,
      available: 0,
      used: 0,
      data: [],
      jmlhsupplier: 0,
    );
    _getMonRak();
    _dataRak = [];
    _getDataSupplier();
    _dataMivo = [];
    _getDataMivo();
    super.initState();
  }

  _getDataMivo() async {
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmlzcCI6IjEyMzQ1Iiwicm9sZV9pZCI6MSwiaWF0IjoxNjcxNTQ2NzQ2LCJleHAiOjE2NzE1NzU1NDZ9.QUi71qQp59wxY8zgbFt5SlgKuZBAZb_W7BZTUufCYDg";
    _dataMivo = await ServiceMivo.getDataMivo(token);
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  _getDataSupplier() async {
    String token = await getToken();
    _dataRak = await ServiceMivo.getSuplier();
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  _getMonRak() async {
    String token = await getToken();
    _monrak = await ServiceMivo.getMonRak();
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  List<DropdownMenuItem<String>> get typeRak {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Rack Type M"), value: "racktypem"),
      const DropdownMenuItem(child: Text("Rack Type B"), value: "racktypeb"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get adressRak {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("A1.01.01"), value: "address1"),
      const DropdownMenuItem(child: Text("B1.02.02"), value: "address2"),
    ];
    return menuItems;
  }

  List<charts.Series<DataRak, String>> _createSampleData() {
    return [
      //charts.Series memiliki 4 paramter wajib
      charts.Series<DataRak, String>(
        data: _dataRak,
        id: 'id',
        seriesColor: charts.ColorUtil.fromDartColor(primaryColor),
        domainFn: (DataRak stockFGModel, _) => stockFGModel.suplier,
        measureFn: (DataRak stockFGModel, _) => stockFGModel.value,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id', null);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chart Material In Vs Out
            AspectRatio(
              aspectRatio: 1.4,
              child: Card(
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
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 8, bottom: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "Pie Chart Batch Material In VS Out",
                                    style: textOpenSans.copyWith(
                                      fontSize: 14,
                                      fontWeight: bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
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
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      width: 145,
                                      height: 30,
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
                                    PieChartData(
                                      pieTouchData: PieTouchData(
                                        touchCallback: (FlTouchEvent event,
                                            pieTouchResponse) {
                                          setState(() {
                                            if (!event
                                                    .isInterestedForInteractions ||
                                                pieTouchResponse == null ||
                                                pieTouchResponse
                                                        .touchedSection ==
                                                    null) {
                                              touchedIndex = -1;
                                              return;
                                            }
                                            touchedIndex = pieTouchResponse
                                                .touchedSection!
                                                .touchedSectionIndex;
                                          });
                                        },
                                      ),
                                      borderData: FlBorderData(show: false),
                                      sectionsSpace: 0,
                                      centerSpaceRadius: 0,
                                      sections: getSections(touchedIndex),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(16),
                                child: IndicatorsWidget(),
                              ),
                              const SizedBox(
                                width: 28,
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 12),
            // Chart Batch Material
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
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                "Pie Chart Material In VS Out",
                                style: textOpenSans.copyWith(
                                  fontSize: 14,
                                  fontWeight: bold,
                                ),
                              ),
                              const SizedBox(width: 8),
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
                                  width: 145,
                                  height: 30,
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
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: DashLineView(
                            fillRate: 1,
                          ),
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
                                  PieChartData(
                                    pieTouchData: PieTouchData(
                                      touchCallback: (FlTouchEvent event,
                                          pieTouchResponse) {
                                        setState(() {
                                          if (!event
                                                  .isInterestedForInteractions ||
                                              pieTouchResponse == null ||
                                              pieTouchResponse.touchedSection ==
                                                  null) {
                                            touchedIndex = -1;
                                            return;
                                          }
                                          touchedIndex = pieTouchResponse
                                              .touchedSection!
                                              .touchedSectionIndex;
                                        });
                                      },
                                    ),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 0,
                                    sections: showingSections(touchedIndex),
                                  ),
                                  swapAnimationDuration: const Duration(
                                      milliseconds: 150), // Optional
                                  swapAnimationCurve: Curves.linear,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Indicator(
                                    color: const Color(0xff63E758),
                                    value:
                                        "${_dataMivo.isNotEmpty ? _dataMivo[0].materialIn : 0} Kg",
                                    text: 'In',
                                    isSquare: false,
                                    size: touchedIndex == 0 ? 18 : 16,
                                    textColor: touchedIndex == 0
                                        ? Colors.black
                                        : blackColor,
                                  ),
                                  Indicator(
                                    color: const Color(0xff165BAA),
                                    value:
                                        '${_dataMivo.isNotEmpty ? _dataMivo[0].materialOut : 0} Kg',
                                    text: 'Out',
                                    isSquare: false,
                                    size: touchedIndex == 1 ? 18 : 16,
                                    textColor: touchedIndex == 1
                                        ? Colors.black
                                        : blackColor,
                                  ),
                                  // Indicator(
                                  //   color: const Color(0xffF765A3),
                                  //   value:
                                  //       '${_dataMivo.isNotEmpty ? _dataMivo[0].stock : 0} Kg',
                                  //   text: 'Stock',
                                  //   isSquare: false,
                                  //   size: touchedIndex == 2 ? 18 : 16,
                                  //   textColor: touchedIndex == 2
                                  //       ? Colors.black
                                  //       : blackColor,
                                  // ),
                                ],
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
            const SizedBox(height: 16),
            // Chart Monitoring Rak
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Text(
                                  "Chart Monitoring Rak",
                                  style: textOpenSans.copyWith(
                                    fontSize: 14,
                                    fontWeight: bold,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 206, 213, 222),
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 6),
                                        child: DropdownButton(
                                          underline: const SizedBox(),
                                          icon: const Icon(
                                            CupertinoIcons.chevron_down,
                                            size: 16,
                                          ),
                                          items: typeRak,
                                          value: slcTypeRak,
                                          style: textOpenSans.copyWith(
                                            color: const Color(0xff7E7E7E),
                                            fontSize: 12,
                                            fontWeight: regular,
                                          ),
                                          elevation: 0,
                                          dropdownColor: whiteColor,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              slcTypeRak = newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Container(
                                      height: 30,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 206, 213, 222),
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 6),
                                        child: DropdownButton(
                                          underline: const SizedBox(),
                                          icon: const Icon(
                                            CupertinoIcons.chevron_down,
                                            size: 16,
                                          ),
                                          items: adressRak,
                                          value: slcAdressRak,
                                          style: textOpenSans.copyWith(
                                            color: const Color(0xff7E7E7E),
                                            fontSize: 12,
                                            fontWeight: regular,
                                          ),
                                          elevation: 0,
                                          dropdownColor: whiteColor,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              slcAdressRak = newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: DashLineView(
                            fillRate: 1,
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 1,
                          child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 16, bottom: 20),
                                  child: charts.BarChart(
                                    _createSampleData(),
                                    animate: true,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 16,
                                  left: 16,
                                  right: 16,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: size,
                                      height: size,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff5E72E4),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Used",
                                          style: textOpenSans.copyWith(
                                            fontWeight: semiBold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          "${_monrak.used.toString()} Kg",
                                          style: textOpenSans.copyWith(
                                            fontSize: 14,
                                            fontWeight: regular,
                                            color: blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      width: size,
                                      height: size,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff63E758),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Available",
                                          style: textOpenSans.copyWith(
                                            fontWeight: semiBold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          _monrak.available.toString(),
                                          style: textOpenSans.copyWith(
                                            fontSize: 14,
                                            fontWeight: regular,
                                            color: blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      width: size,
                                      height: size,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffFB6340),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Supplier",
                                          style: textOpenSans.copyWith(
                                            fontWeight: semiBold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          _monrak.jmlhsupplier.toString(),
                                          style: textOpenSans.copyWith(
                                            fontSize: 14,
                                            fontWeight: regular,
                                            color: blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(int touchedIndex) {
    return List.generate(
      2,
      (i) {
        final isTouched = i == touchedIndex;
        // final opacity = isTouched ? 1.0 : 0.6;
        final double fontSize = isTouched ? 24 : 12;
        final double radius = isTouched ? 80 : 60;

        const color0 = Color(0xff63E758);
        const color1 = Color(0xff165BAA);
        // const color2 = Color(0xffF765A3);

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value:
                  _dataMivo.isNotEmpty ? _dataMivo[0].materialIn.toDouble() : 0,
              title: _dataMivo.isNotEmpty
                  ? _dataMivo[0].materialOut.toString()
                  : 0.toString(),
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: whiteColor,
              ),
              titlePositionPercentageOffset: 0.55,
            );
          case 1:
            return PieChartSectionData(
              color: color1,
              value:
                  _dataMivo.isNotEmpty ? _dataMivo[0].materialIn.toDouble() : 0,
              title: _dataMivo.isNotEmpty
                  ? _dataMivo[0].materialOut.toString()
                  : toString(),
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: whiteColor,
              ),
              titlePositionPercentageOffset: 0.55,
            );
          // case 2:
          //   return PieChartSectionData(
          //     // color: color2.withOpacity(opacity),
          //     color: color2,
          //     value: _dataMivo.isNotEmpty ? _dataMivo[0].stock.toDouble() : 0,
          //     title: _dataMivo.isNotEmpty
          //         ? _dataMivo[0].stock.toString()
          //         : 0.toString(),
          //     radius: radius,
          //     titleStyle: TextStyle(
          //       fontSize: fontSize,
          //       fontWeight: FontWeight.bold,
          //       color: whiteColor,
          //     ),
          //     titlePositionPercentageOffset: 0.6,
          //   );
          default:
            throw Exception('Error Pie Chart');
        }
      },
    );
  }
}
