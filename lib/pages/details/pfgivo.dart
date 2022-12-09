import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:monitoring_mobile/theme.dart';
import 'package:monitoring_mobile/widgets/dashline.dart';
import 'package:monitoring_mobile/widgets/indicators_widget.dart';
import 'package:monitoring_mobile/widgets/pie_chart_sections.dart';

class ProdFGInVSOut extends StatefulWidget {
  const ProdFGInVSOut({Key? key}) : super(key: key);

  @override
  State<ProdFGInVSOut> createState() => _ProdFGInVSOutState();
}

class _ProdFGInVSOutState extends State<ProdFGInVSOut> {
  DateTime? _dateTime;
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id', null);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                margin: const EdgeInsets.symmetric(horizontal: 2),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _dateTime == null
                            ? DateFormat("yMd", "id").format(DateTime.now())
                            : DateFormat("yMd", "id").format(_dateTime!),
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
            const SizedBox(height: 15),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Text(
                    "Pie Chart Production FG In VS Out",
                    style: textOpenSans.copyWith(
                      fontSize: 14,
                      fontWeight: bold,
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
                                touchCallback:
                                    (FlTouchEvent event, pieTouchResponse) {
                                  setState(() {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection ==
                                            null) {
                                      touchedIndex = -1;
                                      return;
                                    }
                                    touchedIndex = pieTouchResponse
                                        .touchedSection!.touchedSectionIndex;
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
          ],
        ),
      ),
    );
  }
}
