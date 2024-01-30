import 'package:flutter/material.dart';

class LabeledDivider extends StatelessWidget {
  final String label;
  final String value;

  const LabeledDivider({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Expanded(
              child: Divider(
                color: Colors.black,
                thickness: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const Expanded(
              child: Divider(
                color: Colors.black,
                thickness: 3,
              ),
            )
          ],
        ),
        Text(
            "~ $value ~",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28))
      ],
    );
  }
}