import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:objectbox/objectbox.dart';
import '../Models/Armour.dart';
import '../Models/Character.dart';
import '../Models/Rewards.dart';
import '../Models/Skills.dart';
import '../Models/Virtues.dart';
import '../Models/Weapon.dart';

class CharacterStateNotifier extends StateNotifier<Character>
{
  CharacterStateNotifier(Character character) : super(character.copyWith());

  void initializeCharacter(Character character)
  {
    state = character;
  }

  void updateName(String newName)
  {
    state = state.copyWith(name: newName);
  }

  void updateHeroicCulture(String newHeroicCulture)
  {
    state = state.copyWith(heroicCulture: newHeroicCulture);
  }

  void updateCulturalBlessing(String newCulturalBlessing)
  {
    state = state.copyWith(culturalBlessing: newCulturalBlessing);
  }

  void updatePatron(String newPatron)
  {
    state = state.copyWith(patron: newPatron);
  }

  void updateCalling(String newCalling)
  {
    state = state.copyWith(calling: newCalling);
  }

  void updateShadowPath(String newShadowPath)
  {
    state = state.copyWith(shadowPath: newShadowPath);
  }

  void updateDistinctiveFeatures(String newDistinctiveFeatures)
  {
    state = state.copyWith(distinctiveFeatures: newDistinctiveFeatures);
  }

  void updateFlaws(String newFlaws)
  {
    state = state.copyWith(flaws: newFlaws);
  }

  void updateTravellingGear(String newTravellingGear)
  {
    state = state.copyWith(travellingGear: newTravellingGear);
  }

  void updateInjury(String newInjury)
  {
    state = state.copyWith(injury: newInjury);
  }

  void updateAge(int newAge)
  {
    state = state.copyWith(age: newAge);
  }

  void updateTreasure(int newTreasure)
  {
    state = state.copyWith(treasure: newTreasure);
  }

  void updateStrengthTn(int newStrengthTn)
  {
    state = state.copyWith(strengthTn: newStrengthTn);
  }

  void updateStrengthRating(int newStrengthRating)
  {
    state = state.copyWith(strengthRating: newStrengthRating);
  }

  void updateEndurance(int newEndurance)
  {
    state = state.copyWith(endurance: newEndurance);
  }

  void updateHeartTn(int newHeartTn)
  {
    state = state.copyWith(heartTn: newHeartTn);
  }

  void updateHeartRating(int newHeartRating)
  {
    state = state.copyWith(heartRating: newHeartRating);
  }

  void updateHope(int newHope)
  {
    state = state.copyWith(hope: newHope);
  }

  void updateWitsTn(int newWitsTn)
  {
    state = state.copyWith(witsTn: newWitsTn);
  }

  void updateWitsRating(int newWitsRating)
  {
    state = state.copyWith(witsRating: newWitsRating);
  }

  void updateParry(int newParry)
  {
    state = state.copyWith(parry: newParry);
  }

  void updateAdventurePoint(int newAdventurePoint)
  {
    state = state.copyWith(adventurePoint: newAdventurePoint);
  }

  void updateSkillPoints(int newSkillPoints)
  {
    state = state.copyWith(skillPoints: newSkillPoints);
  }

  void updateFellowshipScore(int newFellowshipScore)
  {
    state = state.copyWith(fellowshipScore: newFellowshipScore);
  }

  void updateCurrentEndurance(int newCurrentEndurance)
  {
    state = state.copyWith(currentEndurance: newCurrentEndurance);
  }

  void updateLoad(int newLoad)
  {
    state = state.copyWith(load: newLoad);
  }

  void updateFatigue(int newFatigue)
  {
    state = state.copyWith(fatigue: newFatigue);
  }

  void updateCurrentHope(int newCurrentHope)
  {
    state = state.copyWith(currentHope: newCurrentHope);
  }

  void updateShadow(int newShadow)
  {
    state = state.copyWith(shadow: newShadow);
  }

  void updateShadowScars(int newShadowScars)
  {
    state = state.copyWith(shadowScars: newShadowScars);
  }

  void updateValour(int newValour)
  {
    state = state.copyWith(valour: newValour);
  }

  void updateWisdom(int newWisdom)
  {
    state = state.copyWith(wisdom: newWisdom);
  }

  void updateWeary(bool newWeary)
  {
    state = state.copyWith(weary: newWeary);
  }

  void updateMiserable(bool newMiserable)
  {
    state = state.copyWith(miserable: newMiserable);
  }

  void updateWounded(bool newWounded)
  {
    state = state.copyWith(wounded: newWounded);
  }

  void updateRewards(ToMany<Reward> newRewards)
  {
    state = state.copyWith(rewards: newRewards);
  }

  void updateVirtues(ToMany<Virtue> newVirtues)
  {
    state = state.copyWith(virtues: newVirtues);
  }

  void updateSkills(ToMany<Skill> newSkills)
  {
    state = state.copyWith(skills: newSkills);
  }

  void updateWeapons(ToMany<Weapon> newWeapons)
  {
    state = state.copyWith(weapons: newWeapons);
  }

  void updateArmour(ToMany<Armour> newArmour)
  {
    state = state.copyWith(armour: newArmour);
  }

}

final characterStateProvider = StateNotifierProvider.autoDispose.family<CharacterStateNotifier, Character, Character>((ref, character)
{
  return CharacterStateNotifier(character);
});