import 'package:flutter/material.dart';
import 'package:monitoring_mobile/theme.dart';
import 'package:monitoring_mobile/widgets/suplier_card.dart';

class PortalPage extends StatelessWidget {
  const PortalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgrounColor1,
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: ListView(
            children: [
              Text(
                'DCS Production Wharehouse & Delivery',
                style: textOpenSans.copyWith(
                  color: blackColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Suplier',
                style: textOpenSans.copyWith(
                  color: blackColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ListSuplier(),
            ],
          ),
        ));
  }
}

class ListSuplier extends StatelessWidget {
  const ListSuplier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 3 / 1,
      crossAxisSpacing: 30,
      mainAxisSpacing: 60,
      children: [
        SuplierCard(
          namaSupllier: 'Suplier A',
          backgroundSupplier: weightPrimaryColor,
          namaSupllierColor: black2Color,
        ),
        SuplierCard(
          namaSupllier: 'Suplier B',
          backgroundSupplier: weightPrimaryColor,
          namaSupllierColor: black2Color,
        ),
        SuplierCard(
          namaSupllier: 'Suplier C',
          backgroundSupplier: successColor,
          namaSupllierColor: black2Color,
        ),
        SuplierCard(
          namaSupllier: 'Suplier D',
          backgroundSupplier: successColor,
          namaSupllierColor: black2Color,
        ),
        SuplierCard(
          namaSupllier: 'Suplier E',
          backgroundSupplier: primaryColor,
          namaSupllierColor: whiteColor,
        ),
        SuplierCard(
          namaSupllier: 'Suplier F',
          backgroundSupplier: primaryColor,
          namaSupllierColor: whiteColor,
        ),
        SuplierCard(
          namaSupllier: 'Suplier G',
          backgroundSupplier: blackColor,
          namaSupllierColor: whiteColor,
        ),
        SuplierCard(
          namaSupllier: 'Suplier H',
          backgroundSupplier: blackColor,
          namaSupllierColor: whiteColor,
        ),
      ],
    );
  }
}
