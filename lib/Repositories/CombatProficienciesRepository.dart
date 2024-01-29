import 'dart:io';
import '../Models/CombatProficiencies.dart';
import '../objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class CombatProficienciesRepository {
  // Make _singleton private and static
  static final CombatProficienciesRepository _singleton = CombatProficienciesRepository._internal();
  late final Store _store;
  late final Box<CombatProficiencies> _combatProficienciesBox;

  // Use path provider to get app document directory
  Future<Directory> _getApplicationDocumentsDirectory() async {
    return getApplicationDocumentsDirectory();
  }

// In the constructor/init process, set the documents directory:
  CombatProficienciesRepository._internal() {
    _getApplicationDocumentsDirectory().then((Directory directory) {
      _store = Store(getObjectBoxModel(), directory: directory.path);
      _combatProficienciesBox = Box<CombatProficiencies>(_store);
    });
  }

  // Public factory constructor. Returns the singleton instance.
  factory CombatProficienciesRepository() {
    return _singleton;
  }

  // CRUD operations.

  int addArmour(CombatProficiencies combatProficiencies) {
    return _combatProficienciesBox.put(combatProficiencies);
  }

  List<CombatProficiencies> getAllCombatProficiencies() {
    return _combatProficienciesBox.getAll();
  }

  CombatProficiencies? getCombatProficiency(int id) {
    return _combatProficienciesBox.get(id);
  }

  bool removeCombatProficiency(int id) {
    return _combatProficienciesBox.remove(id);
  }

  int updateArmour(CombatProficiencies combatProficiency) {
    return _combatProficienciesBox.put(combatProficiency);
  }
}