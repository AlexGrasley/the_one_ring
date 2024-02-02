import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_one_ring/Models/Armour.dart';
import 'package:the_one_ring/Repositories/CharacterRepository.dart';
import '../Models/Rewards.dart';
import '../Models/Skills.dart';
import '../Models/Weapon.dart';
import '../Repositories/SkillsRepository.dart';

class ArmourStateNotifier extends StateNotifier<List<Armour>> {
  ArmourStateNotifier(super.armour);

  void updateWeapons(List<Armour> armour) {
    state = armour;
  }

  void updateProtection(int armourId, int newProtection) {
    var stateCopy = List<Armour>.from(state); // Make a copy of the state.
    var armourIndex = stateCopy.indexWhere((element) => element.id == armourId);
    var armour = stateCopy[armourIndex];

    // Now you update the copy.
    armour.protection = newProtection;

    stateCopy[armourIndex] = armour;
    state = stateCopy;
  }

  void updateLoad(int armourId, int newLoad) {
    var stateCopy = List<Armour>.from(state); // Make a copy of the state.
    var armourIndex = stateCopy.indexWhere((element) => element.id == armourId);
    var armour = stateCopy[armourIndex];

    // Now you update the copy.
    armour.load = newLoad;

    stateCopy[armourIndex] = armour;
    state = stateCopy;
  }

  void updateParry(int armourId, int newParry) {
    var stateCopy = List<Armour>.from(state); // Make a copy of the state.
    var armourIndex = stateCopy.indexWhere((element) => element.id == armourId);
    var armour = stateCopy[armourIndex];

    // Now you update the copy.
    armour.parry = newParry;

    stateCopy[armourIndex] = armour;
    state = stateCopy;
  }

  void updateNote(int armourId, String newNote) {
    var stateCopy = List<Armour>.from(state); // Make a copy of the state.
    var armourIndex = stateCopy.indexWhere((element) => element.id == armourId);
    var armour = stateCopy[armourIndex];

    // Now you update the copy.
    armour.note = newNote;

    stateCopy[armourIndex] = armour;
    state = stateCopy;
  }

  void updateName(int armourId, String newName) {
    var stateCopy = List<Armour>.from(state); // Make a copy of the state.
    var armourIndex = stateCopy.indexWhere((element) => element.id == armourId);
    var armour = stateCopy[armourIndex];

    // Now you update the copy.
    armour.name = newName;

    stateCopy[armourIndex] = armour;
    state = stateCopy;
  }

  void updateRewards(int armourId, Reward newReward) {
    var stateCopy = List<Armour>.from(state); // Make a copy of the state.
    var armourIndex = stateCopy.indexWhere((element) => element.id == armourId);
    var armour = stateCopy[armourIndex];

    // Now you update the copy.
    armour.rewards.add(newReward);

    stateCopy[armourIndex] = armour;
    state = stateCopy;
  }

}