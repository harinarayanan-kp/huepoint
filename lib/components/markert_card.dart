import 'package:flutter/material.dart';

class MarkertCard extends StatelessWidget {
  const MarkertCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
      height: 150,
      width: double.infinity,
      child: Text('data'),
    );
  }
}
