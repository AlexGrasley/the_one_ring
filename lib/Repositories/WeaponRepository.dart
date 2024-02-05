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
        name: "sword",
        damage: 4,
        injury: 16,
        load: 2
      ),
      Weapon(
          name: "dagger",
          damage: 2,
          injury: 14,
          load: 0
      ),
      Weapon(
          name: "great bow",
          damage: 4,
          injury: 16,
          load: 4
      ),
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