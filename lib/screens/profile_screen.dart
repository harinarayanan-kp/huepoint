import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(255, 142, 145, 147),
            ),
            const Column(
              children: [
                SizedBox(height: 100),
                Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Image(
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://img.playbook.com/XNH4lc_iT1a3gSf1Wlff-CUhJeUCL_PltGecH2BdACc/w:1000/Z3M6Ly9icmFuZGlm/eS11c2VyY29udGVu/dC1kZXYvcHJvZC9s/YXJnZV9wcmV2aWV3/cy9iODYzNWQyOS1j/YzIwLTRmYmItODVm/Mi05ZjZlNjhjNDM5/NzI.webp')),
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
          ),
        )
      ],
    );
  }
}
