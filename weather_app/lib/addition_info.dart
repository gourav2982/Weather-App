import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class AdditionInfo extends StatelessWidget {
  final IconData icon;
  final String name;
  final String mag;

  const AdditionInfo(this.icon, this.name, this.mag, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 60,
        ),
        const Padding(padding: EdgeInsets.all(3)),
        Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
        ),
        const Padding(padding: EdgeInsets.all(0)),
        Text(
          mag,
          style: const TextStyle(fontSize: 22),
        )
      ],
    );
  }
}
