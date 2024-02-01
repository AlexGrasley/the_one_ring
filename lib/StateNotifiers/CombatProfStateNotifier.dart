import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_one_ring/Models/CombatProficiencies.dart';

class CombatProfStateNotifier extends StateNotifier<List<CombatProficiencies>> {
  CombatProfStateNotifier(super.combatProficiencies);

  void updateCombatProfs(List<CombatProficiencies> combatProficiencies) {
    state = combatProficiencies;
  }

  void updateProficiency(int combatProfId, int newProf) {
    var stateCopy = List<CombatProficiencies>.from(state); // Make a copy of the state.
    var combatProfIndex = stateCopy.indexWhere((element) => element.id == combatProfId);
    var combatProf = stateCopy[combatProfIndex];

    // Now you update the copy.
    combatProf.proficiency = newProf;
    stateCopy[combatProfIndex] = combatProf;
    state = stateCopy;
  }

}