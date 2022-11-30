import 'package:flutter/material.dart';
import 'package:monitoring_mobile/theme.dart';

class DetailHomePage extends StatelessWidget {
  const DetailHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Ini Detail Home",
          style: textOpenSans,
        ),
      ),
    );
  }
}
