import 'dart:io';
import 'package:the_one_ring/main.dart';

import '../Models/Weapon.dart';
import '../ObjectBox.dart';
import '../objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class WeaponRepositoryRepository {
  // Make _singleton private and static
  static final WeaponRepositoryRepository _instance = WeaponRepositoryRepository._internal();
  late final Store _store;
  late final Box<Weapon> _weaponBox;
  static bool hasBeenInitialized = false;

// In the constructor/init process, set the documents directory:
  WeaponRepositoryRepository._internal();

  Future<void> _init() async {
    _weaponBox = objectBox.weaponsBox;
  }

// In the constructor/init process, set the documents directory:
  WeaponRepositoryRepository._privateConstructor();

  // Public factory constructor. Asynchronously creates and initializes an instance.
  static Future<WeaponRepositoryRepository> getInstance() async {
    if(!hasBeenInitialized){
      await _instance._init();
      hasBeenInitialized = true;
    }

    return _instance;
  }

  // Public factory constructor. Returns the singleton instance.
  factory WeaponRepositoryRepository() {
    return _instance;
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