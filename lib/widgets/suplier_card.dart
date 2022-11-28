import 'package:flutter/material.dart';
import 'package:monitoring_mobile/theme.dart';

class SuplierCard extends StatelessWidget {
  String namaSupllier;
  Color namaSupllierColor;
  Color backgroundSupplier;
  SuplierCard({
    Key? key,
    required this.namaSupllier,
    required this.backgroundSupplier,
    required this.namaSupllierColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundSupplier,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/images/python.png',
            width: 20,
            height: 20,
          ),
          Text(
            namaSupllier,
            style: textOpenSans.copyWith(
              color: namaSupllierColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
