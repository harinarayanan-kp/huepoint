import 'package:flutter/material.dart';

class Profilecard extends StatelessWidget {
  const Profilecard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
        ),
        height: 100,
        width: 100,
      ),
      const Text('Harinarayanan K P')
    ]);
  }
}
