import 'package:flutter/material.dart';

class ExploreCard extends StatelessWidget {
  const ExploreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 2.5,
      width: MediaQuery.of(context).size.width / 2.5,
      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
      child: Text('data'),
    );
  }
}
