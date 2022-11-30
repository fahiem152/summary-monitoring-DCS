import 'package:flutter/material.dart';
import 'package:monitoring_mobile/theme.dart';
import 'package:monitoring_mobile/widgets/button_default.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DCS Production',
                style: textOpenSans.copyWith(
                  color: blackColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              Text(
                'Warehouse & Delivery',
                style: textOpenSans.copyWith(
                  color: blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Image.asset('assets/images/image-started.png'),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'The best spare part production company with extensive  warehouse storage services and super fast delivery of goods.',
                      textAlign: TextAlign.center,
                      style: textOpenSans.copyWith(
                        color: blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ButtonCustom(
                  title: 'Get Started',
                  press: () {
                    Navigator.pushNamed(context, '/portal');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
