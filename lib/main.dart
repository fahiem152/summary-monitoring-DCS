import 'package:flutter/material.dart';

import 'package:monitoring_mobile/pages/get_started_page.dart';
import 'package:monitoring_mobile/pages/login_page.dart';
import 'package:monitoring_mobile/pages/portal_page.dart';
import 'package:monitoring_mobile/splashscreen.dart';

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
      home: const SplashScreen(),
      routes: {
        '/splashscreen': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/get-started': (context) => const GetStartedPage(),
        '/portal': (context) => const PortalPage(),
        '/home': (context) => const HomePage(),
        // '/detail-home': (context) => const DetailHomePage(),
      },
    );
  }
}
