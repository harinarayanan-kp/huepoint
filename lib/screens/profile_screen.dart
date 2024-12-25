import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(255, 142, 145, 147),
        ),
        Container(
          height: 200,
          width: 200,
          color: Colors.red,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Harinarayanan K P',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 10),
                SvgPicture.asset(
                  'assets/images/verified_badge.svg',
                  height: 30,
                  width: 30,
                ),
              ],
            ),
            const Text(
              'Visual Designer',
              style: TextStyle(fontSize: 12),
            ),
          ],
        )
      ],
    );
  }
}
