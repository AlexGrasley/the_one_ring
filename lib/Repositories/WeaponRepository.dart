import 'package:the_one_ring/main.dart';
import '../Models/Weapon.dart';
import '../objectbox.g.dart';

class WeaponRepository {
  // Make _singleton private and static
  static final WeaponRepository _instance = WeaponRepository._internal();
  late final Store _store;
  late final Box<Weapon> _weaponBox;
  static bool hasBeenInitialized = false;

// In the constructor/init process, set the documents directory:
  WeaponRepository._internal();

  Future<void> _init() async {
    _weaponBox = objectBox.weaponsBox;
  }

// In the constructor/init process, set the documents directory:
  WeaponRepository._privateConstructor();

  // Public factory constructor. Asynchronously creates and initializes an instance.
  static Future<WeaponRepository> getInstance() async {
    if(!hasBeenInitialized){
      await _instance._init();
      hasBeenInitialized = true;
    }

    return _instance;
  }

  // Public factory constructor. Returns the singleton instance.
  factory WeaponRepository() {
    return _instance;
  }

  List<Weapon> getMasterWeaponsList(){
    return List<Weapon>.from({
      Weapon(
        name: "Dagger",
        damage: 2,
        injury: 14,
        load: 0,
        proficiencyType: WeaponProficiencyType.brawling.name,
        handedness: Handedness.oneHanded.name,
        weaponType: WeaponType.melee.name,
        parry: 1,
        isUsableByNaugrim: true,
        isUsableByHalfling: true,
      ),
      Weapon(
        name: "Cudgel",
        damage: 3,
        injury: 12,
        load: 0,
        proficiencyType: WeaponProficiencyType.brawling.name,
        handedness: Handedness.oneHanded.name,
        weaponType: WeaponType.melee.name,
        parry: 1,
        isUsableByNaugrim: true,
        isUsableByHalfling: true,
      ),
      Weapon(
        name: "Club",
        damage: 4,
        injury: 14,
        load: 1,
        proficiencyType: WeaponProficiencyType.brawling.name,
        handedness: Handedness.oneHanded.name,
        weaponType: WeaponType.melee.name,
        parry: 1,
        isUsableByNaugrim: true,
        isUsableByHalfling: true,
      ),
      Weapon(
        name: "Short Sword",
        damage: 4,
        injury: 16,
        load: 1,
        proficiencyType: WeaponProficiencyType.swords.name,
        handedness: Handedness.oneHanded.name,
        weaponType: WeaponType.melee.name,
        parry: 2,
        isUsableByNaugrim: true,
        isUsableByHalfling: true,
      ),
      Weapon(
        name: "Sword",
        damage: 4,
        injury: 16,
        load: 2,
        proficiencyType: WeaponProficiencyType.swords.name,
        handedness: Handedness.oneHanded.name,
        weaponType: WeaponType.melee.name,
        parry: 2,
        isUsableByNaugrim: true,
        isUsableByHalfling: false,
      ),
      Weapon(
        name: "Long Sword",
        damage: 5,
        injury: 16,
        twoHandedInjuryModifier: 2,
        load: 3,
        proficiencyType: WeaponProficiencyType.swords.name,
        handedness: Handedness.both.name,
        weaponType: WeaponType.melee.name,
        parry: 2,
        isUsableByNaugrim: true,
        isUsableByHalfling: false,
      ),
      Weapon(
        name: "Short Spear",
        damage: 3,
        injury: 14,
        twoHandedInjuryModifier: 0,
        load: 2,
        proficiencyType: WeaponProficiencyType.spears.name,
        handedness: Handedness.oneHanded.name,
        weaponType: WeaponType.meleeAndRanged.name,
        parry: 3,
        isUsableByNaugrim: true,
        isUsableByHalfling: true,
      ),
      Weapon(
        name: "Spear",
        damage: 4,
        injury: 14,
        twoHandedInjuryModifier: 2,
        load: 3,
        proficiencyType: WeaponProficiencyType.spears.name,
        handedness: Handedness.both.name,
        weaponType: WeaponType.meleeAndRanged.name,
        parry: 3,
        isUsableByNaugrim: true,
        isUsableByHalfling: true,
      ),
      Weapon(
        name: "Great Spear",
        damage: 5,
        injury: 16,
        twoHandedInjuryModifier: 0,
        load: 4,
        proficiencyType: WeaponProficiencyType.spears.name,
        handedness: Handedness.twoHanded.name,
        weaponType: WeaponType.melee.name,
        parry: 3,
        isUsableByNaugrim: false,
        isUsableByHalfling: false,
      ),
      Weapon(
        name: "Axe",
        damage: 5,
        injury: 18,
        twoHandedInjuryModifier: 0,
        load: 2,
        proficiencyType: WeaponProficiencyType.axes.name,
        handedness: Handedness.oneHanded.name,
        weaponType: WeaponType.melee.name,
        parry: 2,
        isUsableByNaugrim: true,
        isUsableByHalfling: true,
      ),
      Weapon(
        name: "Long-hafted Axe",
        damage: 6,
        injury: 18,
        twoHandedInjuryModifier: 2,
        load: 3,
        proficiencyType: WeaponProficiencyType.axes.name,
        handedness: Handedness.both.name,
        weaponType: WeaponType.melee.name,
        parry: 1,
        isUsableByNaugrim: true,
        isUsableByHalfling: false,
      ),
      Weapon(
        name: "Great Axe",
        damage: 7,
        injury: 20,
        twoHandedInjuryModifier: 0,
        load: 4,
        proficiencyType: WeaponProficiencyType.axes.name,
        handedness: Handedness.twoHanded.name,
        weaponType: WeaponType.melee.name,
        parry: 1,
        isUsableByNaugrim: true,
        isUsableByHalfling: false,
      ),
      Weapon(
        name: "Mattock",
        damage: 7,
        injury: 18,
        twoHandedInjuryModifier: 0,
        load: 3,
        proficiencyType: WeaponProficiencyType.axes.name,
        handedness: Handedness.twoHanded.name,
        weaponType: WeaponType.melee.name,
        parry: 1,
        isUsableByNaugrim: true,
        isUsableByHalfling: false,
      ),
      Weapon(
        name: "Bow",
        damage: 3,
        injury: 14,
        twoHandedInjuryModifier: 0,
        load: 2,
        proficiencyType: WeaponProficiencyType.bows.name,
        handedness: Handedness.twoHanded.name,
        weaponType: WeaponType.ranged.name,
        parry: 0,
        isUsableByNaugrim: true,
        isUsableByHalfling: true,
      ),
      Weapon(
        name: "Great Bow",
        damage: 4,
        injury: 16,
        twoHandedInjuryModifier: 0,
        load: 4,
        proficiencyType: WeaponProficiencyType.bows.name,
        handedness: Handedness.twoHanded.name,
        weaponType: WeaponType.ranged.name,
        parry: 2,
        isUsableByNaugrim: false,
        isUsableByHalfling: false,
      )
    });
  }

  // CRUD operations.

  int addArmour(Weapon weapon) {
    return _weaponBox.put(weapon);
  }

  List<Weapon> getAllWeapons() {
    return _weaponBox.getAll();
  }

  Weapon? getWeapon(int id) {
    return _weaponBox.get(id);
  }

  bool removeWeapon(int id) {
    return _weaponBox.remove(id);
  }

  int updateWeapon(Weapon weapon) {
    return _weaponBox.put(weapon);
  }
}