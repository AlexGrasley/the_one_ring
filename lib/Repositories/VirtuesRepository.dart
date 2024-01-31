import 'dart:io';
import 'package:the_one_ring/main.dart';

import '../Models/Virtues.dart';
import '../ObjectBox.dart';
import '../objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class VirtuesRepository {
  // Make _singleton private and static
  static final VirtuesRepository _instance = VirtuesRepository._internal();
  late final Store _store;
  late final Box<Virtue> _virtuesBox;
  static bool hasBeenInitialized = false;

// In the constructor/init process, set the documents directory:
  VirtuesRepository._internal();

  Future<void> _init() async {
    _virtuesBox = objectBox.virtuesBox;
  }

// In the constructor/init process, set the documents directory:
  VirtuesRepository._privateConstructor();

  // Public factory constructor. Asynchronously creates and initializes an instance.
  static Future<VirtuesRepository> getInstance() async {
    if(!hasBeenInitialized){
      await _instance._init();
      hasBeenInitialized = true;
    }

    return _instance;
  }

  // Public factory constructor. Returns the singleton instance.
  factory VirtuesRepository() {
    return _instance;
  }

  // CRUD operations.

  int addVirtue(Virtue virtue) {
    return _virtuesBox.put(virtue);
  }

  List<Virtue> getAllVirtues() {
    return _virtuesBox.getAll();
  }

  Virtue? getVirtue(int id) {
    return _virtuesBox.get(id);
  }

  bool removeVirtue(int id) {
    return _virtuesBox.remove(id);
  }

  int updateVirtue(Virtue virtue) {
    return _virtuesBox.put(virtue);
  }
}