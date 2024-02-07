import 'dart:math';
import 'package:flutter/material.dart';

import '../Models/Character.dart';
import '../Models/Skills.dart';
import '../Widgets/DiamondShape.dart';
import 'Utilities.dart';
import 'package:the_one_ring/Models/TargetNumberWithTitle.dart';

class Dice {

  static DiceResult rollDice(int d6Count,int targetNumber, RollStatus rollStatus, {bool isMiserable = false}) {
    var rng = Random();
    int d12Result = _rollDTwelve(rollStatus);
    D6Results d6Result = _rollD6(d6Count);
    RollResults rollResults;

    //rolling a 12 is a Gandalf rune and an automatic success
    if(d12Result == 12 && d6Result.greatSuccessCount > 0){
      rollResults = RollResults.greatSuccess;
    }
    else{
      //either a Gandalf run (12), or player exceeded target number.
      rollResults = d12Result == 12 || (d12Result + d6Result.total) > targetNumber ?
        RollResults.success :
        RollResults.failed;
    }

    //if player is miserable, then
    if(isMiserable){
      rollResults = d12Result == 0 ? rollResults = RollResults.failed : rollResults;
    }

    return DiceResult(
        d12: d12Result,
        d6: d6Result.total,
        greatSuccessCount: d6Result.greatSuccessCount,
        rollStatus: rollStatus,
        rollResults: rollResults
    );
  }

  static int _rollDTwelve(RollStatus rollStatus){
    var rng = Random();
    int result = 0;
    int d12One = rng.nextInt(12) + 1;
    int d12Two = rng.nextInt(12) + 1;

    //11's count as a Sauron rune, which results in a 0 for the purposes of the dice role
    d12One = d12One == 11 ? 0 : d12One;
    d12Two = d12Two == 11 ? 0 : d12Two;

    switch(rollStatus){
      case RollStatus.standard:
        result = d12One;
        break;
      case RollStatus.favored:
        result = max(d12One, d12Two);
        break;
      case RollStatus.illFavored:
        result = min(d12One, d12Two);
        break;
    }

    return result;
  }

  static D6Results _rollD6(int diceCount){
    var rng = Random();
    int greatSuccessCount = 0;
    int d6Total = 0;

    for(var i = 0; i < diceCount; i++){
      var result = rng.nextInt(6) + 1;
      if (result == 6){
        greatSuccessCount++;
      }
      d6Total += result;
    }

    return D6Results(total: d6Total, greatSuccessCount: greatSuccessCount);
  }

  static DiceResult getDiceResultsSkill(Skill skill, Character character) {
    var rollStatus = RollStatus.standard;
    if(character.shadow + character.shadowScars == character.currentHope){
      rollStatus = RollStatus.illFavored;
    }
    else if(skill.isFavored){
      rollStatus = RollStatus.favored;
    }
    var results = Dice.rollDice(skill.pips,Utilities.getSkillTargetNumber(character, skill).targetNumber, rollStatus, isMiserable: character.miserable);
    return results;
  }

  static void showDiceResultsSKill(BuildContext context, DiceResult results, Character character, Skill skill) {

    var targetNumber = Utilities.getSkillTargetNumber(character, skill);
    bool passed = results.rollResults == RollResults.success || results.rollResults == RollResults.greatSuccess;
    String rollStatus = _getRollStatusString(results, character);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.55), // Or any other value according to preference
              child: AlertDialog(
                title: const Center(child: Text('Results', style: TextStyle(color: Colors.white))),
                content:
                _diceResultsDisplay(rollStatus, targetNumber, results, passed),
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
      },
    );
  }

  static String _getRollStatusString(DiceResult results, Character character) {
    String rollStatus;

    switch(results.rollStatus){
      case RollStatus.standard:
        rollStatus = "";
        break;
      case RollStatus.favored:
        rollStatus = "Favored";
        break;
      case RollStatus.illFavored:
        rollStatus = "Ill Favored";
    }

    rollStatus += character.miserable ? " ${rollStatus.isEmpty ? "" : "-"} Miserable" : "";
    return rollStatus;
  }

  static Widget _diceResultsDisplay(String rollStatus, TargetNumberWithTitle targetNumber, DiceResult results, bool passed) {
    return Column(
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
    );
  }

}



enum RollStatus {
  standard,
  favored,
  illFavored,
}

enum RollResults {
  failed,
  success,
  greatSuccess,
}

class DiceResult{
  final int d12;
  final int d6;
  final int greatSuccessCount;
  final RollStatus rollStatus;
  final RollResults rollResults;

  DiceResult({required this.d12, required this.d6, required this.greatSuccessCount,required this.rollStatus, required this.rollResults});
}

class D6Results{
  final int total;
  final int greatSuccessCount;

  D6Results({required this.total, required this.greatSuccessCount});

}