import 'package:flutter/material.dart';

import '../Models/Character.dart';
import '../StateNotifiers/CharacterStateNotifier.dart';
import 'TextFormInput.dart';

class ConditionsBoxes extends StatelessWidget {
  const ConditionsBoxes({
    super.key,
    required this.context,
    required this.character,
    required this.characterFormNotifier,
  });

  final BuildContext context;
  final Character character;
  final CharacterStateNotifier characterFormNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          characterFormNotifier.updateWeary(!character.weary);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                          ),
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: character.weary ? Colors.red : Colors.transparent,
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(character.weary? 10 : 0)
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        width: 10,
                      ),
                      const Text("Weary", style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          characterFormNotifier.updateMiserable(!character.miserable);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                          ),
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: character.miserable ? Colors.red : Colors.transparent,
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(character.miserable? 10 : 0)
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        width: 10,
                      ),
                      const Text("Miserable",style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          characterFormNotifier.updateWounded(!character.wounded);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                          ),
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: character.wounded ? Colors.red : Colors.transparent,
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(character.wounded? 10 : 0)
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        width: 10,
                      ),
                      const Text("Wounded",style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormInput(
                initialValue: character.injury,
                labelText: "Injury",
                onChanged: characterFormNotifier.updateInjury,
            )
          ),
        )
      ],
    );
  }
}