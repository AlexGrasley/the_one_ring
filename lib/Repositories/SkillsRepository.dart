import 'dart:io';
import 'package:the_one_ring/main.dart';

import '../Models/Skills.dart';
import '../ObjectBox.dart';
import '../objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class SkillsRepository {
  // Make _singleton private and static
  static final SkillsRepository _instance = SkillsRepository._privateConstructor();

  static bool hasBeenInitialized = false;

  late Store _store;
  late Box<Skill> _skillsBox;


  Future<void> _init() async {
      _skillsBox = objectBox.skillsBox;
  }

// In the constructor/init process, set the documents directory:
  SkillsRepository._privateConstructor();

  // Public factory constructor. Asynchronously creates and initializes an instance.
  static Future<SkillsRepository> getInstance() async {
    if(!hasBeenInitialized){
      await _instance._init();
      hasBeenInitialized = true;
    }

    return _instance;
  }

  // CRUD operations.

  int addSkill(Skill skill) {
    return _skillsBox.put(skill);
  }

  List<Skill> getAllSkills() {
    return _skillsBox.getAll();
  }

  List<Skill> getAllBlankSkills(){
    List<Skill> skills = List<Skill>.from({
      Skill(
          isFavored: false,
          pips: 0,
          name: "Awe"),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Athletics"),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Awareness"),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Hunting"),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Song"),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Craft"),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Enhearten"),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Travel"),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Insight"),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Healing"),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Courtesy"),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Battle"),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Pursuade"),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Stealth"),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Scan"),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Explore"),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Riddle"),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Lore")
    });

    return skills;
  }

  Skill? getSkill(int id) {
    return _skillsBox.get(id);
  }

  bool removeSkill(int id) {
    return _skillsBox.remove(id);
  }

  int updateSkill(Skill skill) {
    return _skillsBox.put(skill);
  }

}