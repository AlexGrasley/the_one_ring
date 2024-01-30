import 'dart:ffi';
import 'dart:io';
import 'package:the_one_ring/Repositories/SkillsRepository.dart';

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

  Future<Character> addCharacter(Character character) async {
    try {
      if(character.skills == null || character.skills!.isEmpty){
        //fill out the characters skills with blank skills so we have them all to modify later
        SkillsRepository skillsRepository = await SkillsRepository.getInstance();
        character.skills = skillsRepository.getAllSkills();
      }

      int id = _characterBox.put(character);
      character.id = id;

      return character;
    }
    catch(e){
      await _instance._init();
      int id = _characterBox.put(character);
      character.id = id;

      return character;
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

  Future<Character> updateCharacter(Character character) async {
    try {
      if(character.skills == null || character.skills!.isEmpty){
        //fill out the characters skills with blank skills so we have them all to modify later
        SkillsRepository skillsRepository = await SkillsRepository.getInstance();
        character.skills = skillsRepository.getAllSkills();
      }
      _characterBox.put(character);
      return character;
    }
    catch(e){
      await _instance._init();
      if(character.skills == null || character.skills!.isEmpty){
        //fill out the characters skills with blank skills so we have them all to modify later
        SkillsRepository skillsRepository = await SkillsRepository.getInstance();
        character.skills = skillsRepository.getAllSkills();
      }
      _characterBox.put(character);
      return character;
    }
  }


}