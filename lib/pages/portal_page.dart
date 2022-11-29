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
                'Select Supplier',
                style: textOpenSans.copyWith(
                  color: blackColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SuplierCard(
                namaSupllier: 'Toyota',
                descriptionSupllier:
                    'One of the best auto parts manufacturers in the world.',
                logoSupllier: 'assets/images/toyota.png',
              ),
              SuplierCard(
                namaSupllier: 'Asana',
                descriptionSupllier:
                    'Asana powers businesses by organizing work in one connected space.',
                logoSupllier: 'assets/images/asana.png',
              ),
              SuplierCard(
                namaSupllier: 'Mitsubishi Motors',
                descriptionSupllier:
                    'Mitsubishi Motors is the sixth largest automotive manufacturer by volume in Japan.',
                logoSupllier: 'assets/images/mitsubishi.png',
              ),
              SuplierCard(
                namaSupllier: 'Ferrari',
                descriptionSupllier:
                    'Ferrari is a manufacturer of high-performance Italian super cars and racing cars based in  Maranello, Italy.',
                logoSupllier: 'assets/images/ferrai.png',
              ),
              SuplierCard(
                namaSupllier: 'Lamborghini',
                descriptionSupllier:
                    'Automobili Lamborghini S.p.A. is an Italian brand and manufacturer of luxury sports cars.',
                logoSupllier: 'assets/images/lamborghini.png',
              ),
              SuplierCard(
                namaSupllier: 'Mitsubishi Motors',
                descriptionSupllier:
                    'Mitsubishi Motors is the sixth largest automotive manufacturer by volume in Japan.',
                logoSupllier: 'assets/images/mitsubishi.png',
              ),
              SuplierCard(
                namaSupllier: 'Asana',
                descriptionSupllier:
                    'Asana powers businesses by organizing work in one connected space.',
                logoSupllier: 'assets/images/asana.png',
              ),
              SuplierCard(
                namaSupllier: 'Mitsubishi Motors',
                descriptionSupllier:
                    'Mitsubishi Motors is the sixth largest automotive manufacturer by volume in Japan.',
                logoSupllier: 'assets/images/mitsubishi.png',
              ),
            ],
          ),
        ));
  }
}
