import 'dart:async';
import 'package:flutter/material.dart';
import 'package:monitoring_mobile/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  splashscreenStart() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.pushNamed(context, '/get-started');
    });
  }

  @override
  void initState() {
    super.initState();
    splashscreenStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset('assets/images/frametop.png'),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Image.asset('assets/images/group.png'),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset('assets/images/framebottom.png'),
            ),
          ]),
        ),
      ),
    );
  }
}
