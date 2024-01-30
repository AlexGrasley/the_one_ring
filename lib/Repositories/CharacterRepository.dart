import 'dart:io';
import '../Models/Character.dart';
import '../objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class CharacterRepository {
  // Make _singleton private and static
  static final CharacterRepository _instance = CharacterRepository._privateConstructor();

  static bool hasBeenInitialized = false;

  late Store _store;
  late Box<Character> _characterBox;

  // Use path provider to get app document directory
  Future<Directory> _getApplicationDocumentsDirectory() async {
    return getApplicationDocumentsDirectory();
  }

  Future<void> _init() async {
    if(hasBeenInitialized){
      return;
    }
    final directory = await _getApplicationDocumentsDirectory();
    _store = Store(getObjectBoxModel(), directory: directory.path);
    _characterBox = Box<Character>(_store);
    hasBeenInitialized = true;
  }

// In the constructor/init process, set the documents directory:
  CharacterRepository._privateConstructor();

  // Public factory constructor. Asynchronously creates and initializes an instance.
  static Future<CharacterRepository> getInstance() async {
    if(!hasBeenInitialized){
      await _instance._init();
    }

    return _instance;
  }


  // CRUD operations.

  Future<int> addCharacter(Character character) async {
    try {
      int id = _characterBox.put(character);
      character.id = id;
      return id;
    }
    catch(e){
      await _instance._init();
      int id = _characterBox.put(character);
      character.id = id;
      return id;
    }
  }

  Future<List<Character>> getAllCharacters() async {
    try {
      return _characterBox.getAll();
    }
    catch(e){
      await _instance._init();
      return _characterBox.getAll();
    }
  }

  Future<Character?> getCharacter(int id) async {
    try {
      return _characterBox.get(id);
    }
    catch(e){
      await _instance._init();
      return _characterBox.get(id);
    }

  }

  Future<bool> removeCharacter(int id) async {
    try {
      return _characterBox.remove(id);
    }
    catch(e){
      await _instance._init();
      return _characterBox.remove(id);
    }

  }

  Future<int> updateCharacter(Character character) async {
    try {
      return _characterBox.put(character);
    }
    catch(e){
      await _instance._init();
      return _characterBox.put(character);
    }
  }


}