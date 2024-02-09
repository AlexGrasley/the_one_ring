import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Models/Rewards.dart';
import '../Models/Weapon.dart';

class WeaponStateNotifier extends StateNotifier<List<Weapon>>
{
  WeaponStateNotifier(super.weapons);

  void updateWeapons(List<Weapon> weapons)
  {
    state = weapons;
  }

  void updateDamage(int weaponId, int newDamage)
  {
    var stateCopy = List<Weapon>.from(state); // Make a copy of the state.
    var weaponIndex = stateCopy.indexWhere((element) => element.id == weaponId);
    var weapon = stateCopy[weaponIndex];

    // Now you update the copy.
    weapon.damage = newDamage;

    stateCopy[weaponIndex] = weapon;
    state = stateCopy;
  }

  void updateInjury(int weaponId, int newInjury)
  {
    var stateCopy = List<Weapon>.from(state); // Make a copy of the state.
    var weaponIndex = stateCopy.indexWhere((element) => element.id == weaponId);
    var weapon = stateCopy[weaponIndex];

    // Now you update the copy.
    weapon.injury = newInjury;

    stateCopy[weaponIndex] = weapon;
    state = stateCopy;
  }

  void updateLoad(int weaponId, int newLoad)
  {
    var stateCopy = List<Weapon>.from(state); // Make a copy of the state.
    var weaponIndex = stateCopy.indexWhere((element) => element.id == weaponId);
    var weapon = stateCopy[weaponIndex];

    // Now you update the copy.
    weapon.load = newLoad;

    stateCopy[weaponIndex] = weapon;
    state = stateCopy;
  }

  void updateNote(int weaponId, String newNote)
  {
    var stateCopy = List<Weapon>.from(state); // Make a copy of the state.
    var weaponIndex = stateCopy.indexWhere((element) => element.id == weaponId);
    var weapon = stateCopy[weaponIndex];

    // Now you update the copy.
    weapon.note = newNote;

    stateCopy[weaponIndex] = weapon;
    state = stateCopy;
  }

  void updateRewards(int weaponId, Reward newReward)
  {
    var stateCopy = List<Weapon>.from(state); // Make a copy of the state.
    var weaponIndex = stateCopy.indexWhere((element) => element.id == weaponId);
    var weapon = stateCopy[weaponIndex];

    // Now you update the copy.
    weapon.rewards.add(newReward);

    stateCopy[weaponIndex] = weapon;
    state = stateCopy;
  }

}