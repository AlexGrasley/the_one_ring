import 'package:flutter/material.dart';
import 'package:the_one_ring/Helpers/HandDrawnDivider.dart';

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
              child: HandDrawnDivider(
                color: Colors.blueGrey,
                thickness: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "$label${value.isEmpty? "" : ":"}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blueGrey),
              ),
            ),
            Text(
                "$value${value.isEmpty? "" : " "}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blueGrey)
            ),
            const Expanded(
              child: HandDrawnDivider(
                color: Colors.blueGrey,
                thickness: 3,
              ),
            )
          ],
        ),
      ],
    );
  }
}