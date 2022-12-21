import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:monitoring_mobile/helper/user_info.dart';
import 'package:monitoring_mobile/models/pfgivo_model.dart';
import 'package:monitoring_mobile/services/pfgivo_service.dart';
import 'package:monitoring_mobile/theme.dart';
import 'package:monitoring_mobile/widgets/dashline.dart';

import 'package:pie_chart/pie_chart.dart';

class ProdFGInVSOut extends StatefulWidget {
  const ProdFGInVSOut({Key? key}) : super(key: key);

  @override
  State<ProdFGInVSOut> createState() => _ProdFGInVSOutState();
}

class _ProdFGInVSOutState extends State<ProdFGInVSOut> {
  int touchedIndex = -1;
  late List<DataPfgivo> _dataPfgivo;
  late List<DataPfgivo> _dataHistory;
  bool loading = true;
  TextEditingController tanggal = TextEditingController();
  final String datenow = DateFormat('dd/MM/yyyy').format(DateTime.now());

  // this will make state when app runs
  @override
  void initState() {
    _dataPfgivo = [];
    _dataHistory = [];
    _getPfgivo();
    _getHistory();
    tanggal.text = datenow;
    super.initState();
  }

  void _getPfgivo() async {
    String token = await getToken();
    _dataPfgivo = await ServicePfgivo.getData(token, date: tanggal.text);
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  void _getHistory() async {
    String token = await getToken();
    _dataHistory = await ServicePfgivo.getHistory(token);
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id', null);
    // this is a map of data bacause piechart need a map
    Map<String, double> dataMap = {
      "in": _dataPfgivo.isNotEmpty ? _dataPfgivo[0].stockin.toDouble() : 0,
      "out": _dataPfgivo.isNotEmpty ? _dataPfgivo[0].stockout.toDouble() : 0,
      "stock":
          _dataPfgivo.isNotEmpty ? _dataPfgivo[0].totalstock.toDouble() : 0,
    };
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Pie Production FG In Vs Out",
                                style: textOpenSans.copyWith(
                                  fontSize: 14,
                                  fontWeight: bold,
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () async {
                                  DateTime? pickedDate2 = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101));

                                  if (pickedDate2 != null) {
                                    String formattedDate2 =
                                        DateFormat("yyyy-MM-dd", "id")
                                            .format(pickedDate2);
                                    print(formattedDate2);

                                    setState(() {
                                      tanggal.text = formattedDate2;
                                      _getPfgivo();
                                    });
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
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
                                          tanggal.text.isEmpty
                                              ? DateFormat("yyyy-MM-dd", "id")
                                                  .format(DateTime.now())
                                              : tanggal.text,
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
                        _dataPfgivo.isEmpty
                            ? SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Tidak ada grafik di hari ini",
                                    style: textOpenSans.copyWith(
                                      fontSize: 14,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                                ),
                              )
                            : Row(
                                children: [
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Expanded(
                                    child: AspectRatio(
                                      aspectRatio: 1.6,
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
                                        chartValuesOptions:
                                            const ChartValuesOptions(
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
            _dataPfgivo.isEmpty
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Text(
                            "Last 10 Histori",
                            style: textOpenSans.copyWith(
                              fontSize: 14,
                              fontWeight: bold,
                            ),
                          ),
                        ),
                      ),
                      const DashLineView(
                        fillRate: 1,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: _dataHistory.length,
                          itemBuilder: ((context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              _dataHistory[index]
                                                  .order
                                                  .toString(),
                                              style: textOpenSans.copyWith(
                                                fontSize: 16,
                                                fontWeight: bold,
                                              ),
                                            ),
                                            Text(
                                              " Order",
                                              style: textOpenSans,
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Barang ${_dataHistory[index].idWorkorder}",
                                          style: textOpenSans,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      DateFormat("yMd", "id_ID").format(
                                          _dataHistory[index].createdAt),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        "Last 10 Histori",
                        style: textOpenSans.copyWith(
                          fontSize: 14,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                  ),
            const DashLineView(fillRate: 1),
            ListView.builder(
                shrinkWrap: true,
                itemCount: _dataPfgivo.length,
                itemBuilder: ((context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    _dataPfgivo[index].order.toString(),
                                    style: textOpenSans.copyWith(
                                      fontSize: 16,
                                      fontWeight: bold,
                                    ),
                                  ),
                                  Text(
                                    " Order",
                                    style: textOpenSans,
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Barang ${_dataPfgivo[index].idWorkorder}",
                                style: textOpenSans,
                              ),
                            ],
                          ),
                          Text(
                            DateFormat("yMd", "id_ID")
                                .format(_dataPfgivo[index].createdAt),
                          ),
                        ],
                      ),
                    ),
                  );
                })),
          ],
        ),
      ),
    );
  }
}
