import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_one_ring/Repositories/CharacterRepository.dart';
import '../Models/Skills.dart';
import '../Repositories/SkillsRepository.dart';

class SkillStateNotifier extends StateNotifier<List<Skill>> {
  SkillStateNotifier(super.skills);

  void updateSkill(List<Skill> skills) {
    state = skills;
  }

  void updateFavored(int skillId, bool newIsFavored) {
    var stateCopy = List<Skill>.from(state); // Make a copy of the state.
    var skillIndex = stateCopy.indexWhere((element) => element.id == skillId);
    var skill = stateCopy[skillIndex];

    // Now you update the copy.
    skill.isFavored = newIsFavored;
    stateCopy[skillIndex] = skill;
    state = stateCopy;
  }

  void updatePips(int skillId, int newPips) {
    var stateCopy = List<Skill>.from(state); // Make a copy of the state.
    var skillIndex = stateCopy.indexWhere((element) => element.id == skillId);
    var skill = stateCopy[skillIndex];

    // Now you update the copy.
    skill.pips = newPips;
    stateCopy[skillIndex] = skill;
    state = stateCopy;
  }

}