import 'dart:io';
import '../Models/Weapon.dart';
import '../objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class CombatProficienciesRepository {
  // Make _singleton private and static
  static final CombatProficienciesRepository _singleton = CombatProficienciesRepository._internal();
  late final Store _store;
  late final Box<Weapon> _weaponBox;

  // Use path provider to get app document directory
  Future<Directory> _getApplicationDocumentsDirectory() async {
    return getApplicationDocumentsDirectory();
  }

// In the constructor/init process, set the documents directory:
  CombatProficienciesRepository._internal() {
    _getApplicationDocumentsDirectory().then((Directory directory) {
      _store = Store(getObjectBoxModel(), directory: directory.path);
      _weaponBox = Box<Weapon>(_store);
    });
  }

  // Public factory constructor. Returns the singleton instance.
  factory CombatProficienciesRepository() {
    return _singleton;
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