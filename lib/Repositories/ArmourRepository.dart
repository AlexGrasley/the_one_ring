import 'dart:io';
import '../Models/Armour.dart';
import '../objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class ArmourRepository {
  // Make _singleton private and static
  static final ArmourRepository _singleton = ArmourRepository._internal();
  late final Store _store;
  late final Box<Armour> _armourBox;

  // Use path provider to get app document directory
  Future<Directory> _getApplicationDocumentsDirectory() async {
    return getApplicationDocumentsDirectory();
  }

// In the constructor/init process, set the documents directory:
  ArmourRepository._internal() {
    _getApplicationDocumentsDirectory().then((Directory directory) {
      _store = Store(getObjectBoxModel(), directory: directory.path);
      _armourBox = Box<Armour>(_store);
    });
  }

  // Public factory constructor. Returns the singleton instance.
  factory ArmourRepository() {
    return _singleton;
  }

  // CRUD operations.

  int addArmour(Armour armour) {
    return _armourBox.put(armour);
  }

  List<Armour> getAllArmour() {
    return _armourBox.getAll();
  }

  Armour? getArmour(int id) {
    return _armourBox.get(id);
  }

  bool removeArmour(int id) {
    return _armourBox.remove(id);
  }

  int updateArmour(Armour armour) {
    return _armourBox.put(armour);
  }
}