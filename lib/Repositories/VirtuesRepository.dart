import 'dart:io';
import '../Models/Virtues.dart';
import '../objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class VirtuesRepository {
  // Make _singleton private and static
  static final VirtuesRepository _singleton = VirtuesRepository._internal();
  late final Store _store;
  late final Box<Virtue> _virtuesBox;

  // Use path provider to get app document directory
  Future<Directory> _getApplicationDocumentsDirectory() async {
    return getApplicationDocumentsDirectory();
  }

// In the constructor/init process, set the documents directory:
  VirtuesRepository._internal() {
    _getApplicationDocumentsDirectory().then((Directory directory) {
      _store = Store(getObjectBoxModel(), directory: directory.path);
      _virtuesBox = Box<Virtue>(_store);
    });
  }

  // Public factory constructor. Returns the singleton instance.
  factory VirtuesRepository() {
    return _singleton;
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