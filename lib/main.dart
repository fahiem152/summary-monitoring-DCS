import 'package:flutter/material.dart';
import 'package:monitoring_mobile/pages/portal_page.dart';

import 'pages/details/dummy.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PortalPage(),
      routes: {
        '/portal': (context) => const PortalPage(),
        '/home': (context) => const HomePage(),
        '/detail-home': (context) => const DetailHomePage(),
      },
    );
  }
}
