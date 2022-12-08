import 'package:flutter/material.dart';

class ProdFGInVSOut extends StatelessWidget {
  const ProdFGInVSOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Text("Qty/Box"),
            )
          ],
        ),
      ),
    );
  }
}
