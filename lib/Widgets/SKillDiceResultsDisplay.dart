import 'package:flutter/material.dart';

import '../Helpers/Dice.dart';
import '../Models/DiceResult.dart';
import '../Models/TargetNumberWithTitle.dart';
import 'DiamondShape.dart';

class SkillDiceResultsDisplay extends StatelessWidget {
  const SkillDiceResultsDisplay({
    super.key,
    required this.rollStatus,
    required this.targetNumber,
    required this.results,
    required this.passed,
  });

  final String rollStatus;
  final TargetNumberWithTitle targetNumber;
  final DiceResult results;
  final bool passed;

  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.55), // Or any other value according to preference
            child: AlertDialog(
              title: const Center(child: Text('Results', style: TextStyle(color: Colors.white))),
              content:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      rollStatus,
                      style: const TextStyle(fontSize: 16, color: Colors.white)
                  ),
                  Text(
                    targetNumber.name,
                    style: const TextStyle(fontSize: 36, color: Colors.white),
                  ),
                  DiamondShape(targetNumber.targetNumber.toString(),"", size: 75),
                  const SizedBox(height: 10),
                  Column(
                      children: [
                        Text("D-12: ${results.d12}", style: const TextStyle(color: Colors.blueGrey)),
                        Text("D-6: ${results.d6}", style: const TextStyle(color: Colors.blueGrey))
                      ]
                  ),
                  const SizedBox(height: 10),
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: passed ?Colors.green : Colors.red,
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                      ),
                      child: passed?
                      Text(
                          (results.rollResults == RollResults.greatSuccess ?
                          "Great Success! ${(results.greatSuccessCount > 1 ? "x${results.greatSuccessCount}" : "")}" :
                          "Success"),
                          style: const TextStyle(fontSize: 26, color: Colors.white)) :
                      const Text("Failed!", style: TextStyle(fontSize: 26, color: Colors.black))
                  )
                ],
              ),
              actions: [
                ElevatedButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          )
      );


  }
}