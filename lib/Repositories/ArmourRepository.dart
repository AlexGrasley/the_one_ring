import 'dart:io';
import 'package:the_one_ring/main.dart';

import '../Models/Armour.dart';
import '../ObjectBox.dart';
import '../objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class ArmourRepository {
  // Make _singleton private and static
  static final ArmourRepository _instance = ArmourRepository._internal();
  late final Store _store;
  late final Box<Armour> _armourBox;
  static bool hasBeenInitialized = false;

// In the constructor/init process, set the documents directory:
  ArmourRepository._internal() ;

  Future<void> _init() async {
    _armourBox = objectBox.armourBox;
  }

// In the constructor/init process, set the documents directory:
  ArmourRepository._privateConstructor();

  // Public factory constructor. Asynchronously creates and initializes an instance.
  static Future<ArmourRepository> getInstance() async {
    if(!hasBeenInitialized){
      await _instance._init();
      hasBeenInitialized = true;
    }

    return _instance;
  }

  // Public factory constructor. Returns the singleton instance.
  factory ArmourRepository() {
    return _instance;
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