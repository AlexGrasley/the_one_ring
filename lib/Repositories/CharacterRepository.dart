import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_one_ring/Models/CombatProficiencies.dart';
import 'package:the_one_ring/Models/Weapon.dart';
import 'package:the_one_ring/Repositories/CombatProficienciesRepository.dart';
import 'package:the_one_ring/Repositories/SkillsRepository.dart';

import '../Models/Armour.dart';
import '../Models/Character.dart';
import '../Models/Skills.dart';
import '../main.dart';
import '../objectbox.g.dart';

class CharacterRepository
{
  // Make _singleton private and static
  static final CharacterRepository _instance = CharacterRepository._privateConstructor();

  static bool hasBeenInitialized = false;

  late Box<Character> _characterBox;

  Future<void> _init() async
  {
    _characterBox = objectBox.characterBox;
  }

  // In the constructor/init process, set the documents directory:
  CharacterRepository._privateConstructor();

  // Public factory constructor. Asynchronously creates and initializes an instance.
  static Future<CharacterRepository> getInstance() async
  {
    if(!hasBeenInitialized)
    {
      await _instance._init();
      hasBeenInitialized = true;
    }

    return _instance;
  }

  // CRUD operations.

  Future<Character> addCharacter(Character character) async
  {
    if(character.skills.isEmpty)
    {

      //fill out the characters skills with blank skills so we have them all to modify later
      SkillsRepository skillsRepository = await SkillsRepository.getInstance();

      for(var skill in skillsRepository.getAllBlankSkills())
      {
        character.skills.add(skill);
      }

    }

    _characterBox.put(character);
    return character;
  }

  List<Skill>? getCharacterSkills(int id)
  {
    var character = _characterBox.get(id);
    var skills = character?.skills;
    return skills?.toList();
  }

  List<CombatProficiencies>? getCharacterCombatProfs(int id)
  {
    var character = _characterBox.get(id);
    var combatProfs = character?.combatProficiencies;
    return combatProfs?.toList();
  }

  List<Weapon>? getCharacterWeapons(int id)
  {
    var character = _characterBox.get(id);
    var weapons = character?.weapons;
    return weapons?.toList();
  }

  List<Armour>? getCharacterArmour(int id)
  {
    var character = _characterBox.get(id);
    var armour = character?.armour;
    return armour?.toList();
  }

  Future<List<Character>> getAllCharacters() async
  {
    return _characterBox.getAllAsync();
  }

  Future<Character?> getCharacter(int id) async
  {
    try
    {
      return _characterBox.get(id);
    }
    catch(e)
    {
      await _instance._init();
      return _characterBox.get(id);
    }

  }

  Future<bool> removeCharacter(int id) async
  {
    try
    {
      return _characterBox.remove(id);
    }
    catch(e)
    {
      await _instance._init();
      return _characterBox.remove(id);
    }

  }

  Future<Character> updateCharacter(Character character) async
  {
    try
    {
      if(character.skills.isEmpty)
      {
        //fill out the characters skills with blank skills so we have them all to modify later
        SkillsRepository skillsRepository = await SkillsRepository.getInstance();
        for(var skill in skillsRepository.getAllBlankSkills())
        {
          character.skills.add(skill);
        }
      }

      if(character.combatProficiencies.isEmpty)
      {
        CombatProficienciesRepository combatRepo = await CombatProficienciesRepository.getInstance();
        for(var combatProf in combatRepo.getAllBlankCombatProficiencies())
        {
          character.combatProficiencies.add(combatProf);
        }
      }

      _characterBox.put(character);
      return character;

    } catch (e)
    {
      //TODO: figure out something to do with this error.
    }
    return Character();
  }

}

final characterRepositoryProvider = Provider((ref) => CharacterRepository.getInstance());