import 'package:flutter/material.dart';
import 'package:monitoring_mobile/models/homepage_tile.dart';
import 'package:monitoring_mobile/theme.dart';

import 'mivo.dart';
import 'pfgivo.dart';

class DetailHomePage extends StatefulWidget {
  final ListBodyHome listBodyHome;
  final int index;
  const DetailHomePage(
      {Key? key, required this.listBodyHome, required this.index})
      : super(key: key);

  @override
  State<DetailHomePage> createState() => _DetailHomePageState();
}

class _DetailHomePageState extends State<DetailHomePage> {
  // Appbar
  PreferredSize getAppbar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(55.0),
      child: AppBar(
        backgroundColor: backgrounColor1,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: black2Color,
        ),
        elevation: 1,
        title: Text(
          widget.listBodyHome.title,
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      ),
    );
  }

  // Body
  Widget getBody() {
    return IndexedStack(
      index: widget.index,
      children: const [
        // Production Finish Good In Vs Out
        ProdFGInVSOut(),
        MaterialInVSOut(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: getBody(),
    );
  }
}
