import 'dart:io';
import '../Models/Character.dart';
import '../objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class CharacterRepository {
  // Make _singleton private and static
  static final CharacterRepository _singleton = CharacterRepository._internal();
  late final Store _store;
  late final Box<Character> _characterBox;

  // Use path provider to get app document directory
  Future<Directory> _getApplicationDocumentsDirectory() async {
    return getApplicationDocumentsDirectory();
  }

  Future<void> init() async {
    final directory = await _getApplicationDocumentsDirectory();
    _store = Store(getObjectBoxModel(), directory: directory.path);
    _characterBox = Box<Character>(_store);
  }

// In the constructor/init process, set the documents directory:
  CharacterRepository._internal();

  // Public factory constructor. Returns the singleton instance.
  factory CharacterRepository() {
    return _singleton;
  }

  // CRUD operations.

  int addCharacter(Character character) {
    return _characterBox.put(character);
  }

  List<Character> getAllCharacters() {
    return _characterBox.getAll();
  }

  Character? getCharacter(int id) {
    return _characterBox.get(id);
  }

  Character? getCharacterByName(String name) {
    final query = _characterBox.query(Character_.name.equals(name)).build();
    final characters = query.find();
    query.close();

    if (characters.isNotEmpty) {
      return characters.first;
    } else {
      return null;
    }
  }

  bool removeCharacter(int id) {
    return _characterBox.remove(id);
  }

  int updateCharacter(Character character) {
    return _characterBox.put(character);
  }
}