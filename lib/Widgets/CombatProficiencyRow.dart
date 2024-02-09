import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/CombatProficiencies.dart';
import '../Screens/CombatDataForm.dart';
import '../StateNotifiers/CombatProfStateNotifier.dart';

class CombatProficiencyRow extends StatelessWidget
{
  const CombatProficiencyRow({
    super.key,
    required this.context,
    required this.ref,
    required this.index,
    required this.combatProf,
    required this.combatProfFormProvider,
  });

  final BuildContext context;
  final WidgetRef ref;
  final int index;
  final CombatProficiencies combatProf;
  final CombatProfStateNotifier combatProfFormProvider;

  @override
  Widget build(BuildContext context)
  {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
        [
          Expanded( // Add Expanded widget here
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
                    Text(
                      combatProf.name,
                      style: const TextStyle(color: Colors.blueGrey),// use TextDecoration.underline to underline the text
                    ),
                    const Divider(
                      color: Colors.redAccent,
                      thickness: 1,
                    )
                  ],
                ),
              )
          ),
          Expanded( // Wrap Row with Expanded to make the boxes take the remaining space in the row
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Align boxes to the right
              children: List.generate(6, (combatProfIndex)
              {
                return Transform.rotate( // add Transform.rotate widget
                  angle: pi / 4, // rotate 45 degrees
                  child: InkWell(
                    onTap: () async {
                      combatProfFormProvider.updateProficiency(
                          combatProf.id,
                          combatProf.proficiency == 1 &&
                              combatProfIndex == 0 ?
                          0 :
                          combatProfIndex + 1);
                      var repo = await ref.watch(combatProfRepositoryProvider);
                      repo.updateProficiency(combatProf);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.all(2),
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red), // add color red to borders
                      ),
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            color: combatProfIndex < combatProf.proficiency ? Colors.redAccent : Colors.transparent,
                            border: Border.all(color: Colors.red), // add color red to borders
                            borderRadius: combatProfIndex < combatProf.proficiency ? BorderRadius.circular(10) : BorderRadius.circular(0)
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}