import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:flutter_pagination/widgets/button_styles.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:monitoring_mobile/constan.dart';
import 'package:monitoring_mobile/pages/get_started_page.dart';
import 'package:monitoring_mobile/services/stock_fg_service.dart';
import '../../helper/user_info.dart';
import '../../models/api_response_model.dart';
import '../../models/stock_fg_model.dart';
import '../../theme.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class StockFG extends StatefulWidget {
  const StockFG({Key? key}) : super(key: key);

  @override
  State<StockFG> createState() => _StockFGState();
}

class _StockFGState extends State<StockFG> {
  TextEditingController tanggal = TextEditingController();
  final String datenow = DateFormat('dd/MM/yyyy').format(DateTime.now());

  List<StockFGModel> stock = [];
  bool loading = true;
  bool _loading = true;
  List<dynamic> tabelStockList = [];

  void getData({required String tanggal}) async {
    String token = await getToken();
    var response = await http.get(
      Uri.parse(
        tanggal == ''
            ? baseURL + "/api/fg/stock/chart"
            : baseURL + "/api/fg/stock/chart?date=$tanggal",
      ),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    List data = json.decode(response.body)['list'];

    setState(() {
      //memasukan data json ke dalam model
      stock = stockModelFromJson(data);

      loading = false;
    });
  }

  int currentPage = 1;
  fungsigetTabelStockOpnameFg(
      {required String supplier, required String page}) async {
    ApiResponse response =
        await getTabelStockOpnameFg(supplier: supplier, page: page);
    if (response.error == null) {
      setState(() {
        tabelStockList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const GetStartedPage()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  int totalPage = 0;
  String kondisi = '';
  void getPaginasi({required String supplier}) async {
    String token = await getToken();
    var response = await http.get(
      Uri.parse(
        baseURL + "/api/fg/stock/detail?supplier=$supplier",
      ),
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token'
      },
    );
    int total = json.decode(response.body)['total_page'];

    setState(() {
      //memasukan data json ke dalam model
      totalPage = total;
      kondisi = 'ada';
      loading = false;
    });
  }

  final List<String> itemsSupplier = [
    'HPP',
    'TKI',
  ];

  String? pilihSupplier;

  List<charts.Series<StockFGModel, String>> chartStockOpnameFg() {
    return [
      charts.Series<StockFGModel, String>(
          data: stock,
          id: 'id',
          seriesColor: charts.ColorUtil.fromDartColor(primaryColor),
          domainFn: (StockFGModel stockFGModel, _) => stockFGModel.partName,
          measureFn: (StockFGModel stockFGModel, _) => stockFGModel.qty)
    ];
  }

  List<Widget> _getTitle() {
    return [
      _getTitleItemWidget('Part Number', 250),
      _getTitleItemWidget('Name Name', 230),
      _getTitleItemWidget('Min', 50),
      _getTitleItemWidget('Max', 50),
      _getTitleItemWidget('Inbound', 70),
      _getTitleItemWidget('Outbound', 80),
      _getTitleItemWidget('Sisa', 50),
      _getTitleItemWidget('Status', 85),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: const TextStyle(color: Colors.white)),
      width: width,
      color: const Color(0xff4E4E53),
      height: 30,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _firstColumnRow(BuildContext context, int index) {
    TabelStckFGModel tabelStckFGModel = tabelStockList[index];
    return Center(
      child: Container(
        child: Text(tabelStckFGModel.partNumber),
        width: 250,
        height: 52,
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget _rightHandSideColumnRow(BuildContext context, int index) {
    TabelStckFGModel tabelStckFGModel = tabelStockList[index];
    return Row(
      children: <Widget>[
        ItemListTabel(pWidth: 230, value: tabelStckFGModel.partName),
        ItemListTabel(pWidth: 50, value: tabelStckFGModel.min.toString()),
        ItemListTabel(pWidth: 50, value: tabelStckFGModel.max.toString()),
        ItemListTabel(pWidth: 70, value: tabelStckFGModel.inbound.toString()),
        ItemListTabel(pWidth: 80, value: tabelStckFGModel.outbond.toString()),
        ItemListTabel(pWidth: 50, value: tabelStckFGModel.sisa.toString()),
        Container(
          color: tabelStckFGModel.status == 'NORMAL'
              ? Colors.green
              : tabelStckFGModel.status == 'OVERLOAD'
                  ? Colors.red
                  : Colors.orange,
          child: Center(
            child: Text(
              tabelStckFGModel.status,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          width: 85,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
    // });
  }

  @override
  void initState() {
    super.initState();
    getData(tanggal: '');
    pilihSupplier = 'HPP';
    fungsigetTabelStockOpnameFg(
        supplier: pilihSupplier.toString(), page: currentPage.toString());
    // getSuplier();
    getPaginasi(supplier: pilihSupplier.toString());

    tanggal.text = datenow;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Card(
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
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Stock Opname Finish Good',
                                style: textOpenSans.copyWith(
                                  color: blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
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
                                    String formattedDate2 =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate2);
                                    print(formattedDate2);

                                    setState(() {
                                      tanggal.text = formattedDate2;
                                      getData(tanggal: tanggal.text);
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
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
                        Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: charts.BarChart(
                                chartStockOpnameFg(),
                                animate: true,
                                domainAxis: const charts.OrdinalAxisSpec(
                                  renderSpec: charts.SmallTickRendererSpec(
                                    // Rotation Here,
                                    labelRotation: -90,
                                    labelAnchor: charts.TickLabelAnchor.before,
                                    labelOffsetFromTickPx: -5,
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
            ),
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 500,
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Stock Opname Finish Good',
                                  style: textOpenSans.copyWith(
                                    color: blackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 40,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: primaryColor, width: 1.0),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        icon: const ImageIcon(
                                          AssetImage(
                                              'assets/icons/arrow-down.png'),
                                        ),
                                        dropdownColor: const Color(0xffF0F1F2),
                                        borderRadius: BorderRadius.circular(15),
                                        isExpanded: true,
                                        items: itemsSupplier
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff4B556B),
                                                      letterSpacing: 1,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList(),
                                        menuMaxHeight: 300,
                                        value: pilihSupplier,
                                        onChanged: (value) {
                                          setState(() {
                                            pilihSupplier = value as String;
                                            fungsigetTabelStockOpnameFg(
                                                supplier:
                                                    pilihSupplier.toString(),
                                                page: currentPage.toString());
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: HorizontalDataTable(
                                leftHandSideColumnWidth: 100,
                                rightHandSideColumnWidth: 620,
                                isFixedHeader: true,
                                headerWidgets: _getTitle(),
                                leftSideItemBuilder: _firstColumnRow,
                                rightSideItemBuilder: _rightHandSideColumnRow,
                                itemCount: tabelStockList.length,
                                rowSeparatorWidget: const Divider(
                                  color: Colors.black54,
                                  height: 1.0,
                                  thickness: 0.0,
                                ),
                                // leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
                                // rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
                              ),
                            ),
                            kondisi == 'ada'
                                ? Pagination(
                                    paginateButtonStyles:
                                        PaginateButtonStyles(),
                                    prevButtonStyles: PaginateSkipButton(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20))),
                                    nextButtonStyles: PaginateSkipButton(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20))),
                                    onPageChange: (number) {
                                      setState(() {
                                        currentPage = number;
                                        print(currentPage);
                                        fungsigetTabelStockOpnameFg(
                                            supplier: pilihSupplier.toString(),
                                            page: currentPage.toString());
                                      });
                                    },
                                    useGroup: true,
                                    totalPage: kondisi == 'ada' ? 2 : totalPage,
                                    show: 1,
                                    currentPage: currentPage,
                                  )
                                : const SizedBox(),
                          ],
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemListTabel extends StatelessWidget {
  const ItemListTabel({Key? key, required this.pWidth, required this.value})
      : super(key: key);

  final double pWidth;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(value),
      width: pWidth,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
    ;
  }
}
