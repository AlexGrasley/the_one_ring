import 'package:the_one_ring/Models/Weapon.dart';
import 'package:the_one_ring/main.dart';

import '../Models/CombatProficiencies.dart';
import '../objectbox.g.dart';

class CombatProficienciesRepository
{
  // Make _singleton private and static
  static final CombatProficienciesRepository _instance = CombatProficienciesRepository._internal();
  late final Store _store;
  late final Box<CombatProficiencies> _combatProficienciesBox;
  static bool hasBeenInitialized = false;

  // In the constructor/init process, set the documents directory:
  CombatProficienciesRepository._internal();

  Future<void> _init() async
  {
    _combatProficienciesBox = objectBox.combatProficienciesBox;
  }

  // In the constructor/init process, set the documents directory:
  CombatProficienciesRepository._privateConstructor();

  // Public factory constructor. Asynchronously creates and initializes an instance.
  static Future<CombatProficienciesRepository> getInstance() async
  {
    if(!hasBeenInitialized)
    {
      await _instance._init();
      hasBeenInitialized = true;
    }

    return _instance;
  }

  // Public factory constructor. Returns the singleton instance.
  factory CombatProficienciesRepository()
  {
    return _instance;
  }

  List<CombatProficiencies> getAllBlankCombatProficiencies()
  {
    List<CombatProficiencies> combatProficiencies = List<CombatProficiencies>.from({
      CombatProficiencies(
        name: WeaponProficiencyType.axes.name,
        proficiency: 0
      ),
      CombatProficiencies(
        name: WeaponProficiencyType.bows.name,
        proficiency: 0
      ),
      CombatProficiencies(
        name: WeaponProficiencyType.spears.name,
        proficiency: 0
      ),
      CombatProficiencies(
        name: WeaponProficiencyType.swords.name,
        proficiency: 0
      ),
      CombatProficiencies(
          name: WeaponProficiencyType.brawling.name,
          proficiency: 0
      ),
    });

    return combatProficiencies;
  }

  // CRUD operations.

  int addProficiency(CombatProficiencies combatProficiencies)
  {
    return _combatProficienciesBox.put(combatProficiencies);
  }

  List<CombatProficiencies> getAllCombatProficiencies()
  {
    return _combatProficienciesBox.getAll();
  }

  CombatProficiencies? getCombatProficiency(int id)
  {
    return _combatProficienciesBox.get(id);
  }

  bool removeCombatProficiency(int id)
  {
    return _combatProficienciesBox.remove(id);
  }

  int updateProficiency(CombatProficiencies combatProficiency)
  {
    return _combatProficienciesBox.put(combatProficiency);
  }
}