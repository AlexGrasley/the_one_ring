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
          name: "Awe",
          skillClass: SkillClass.strength
      ),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Athletics",
          skillClass: SkillClass.strength),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Awareness",
          skillClass: SkillClass.strength),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Hunting",
          skillClass: SkillClass.strength),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Song",
          skillClass: SkillClass.strength),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Craft",
          skillClass: SkillClass.strength),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Enhearten",
          skillClass: SkillClass.heart),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Travel",
          skillClass: SkillClass.heart),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Insight",
          skillClass: SkillClass.heart),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Healing",
          skillClass: SkillClass.heart),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Courtesy",
          skillClass: SkillClass.heart),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Battle",
          skillClass: SkillClass.heart),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Pursuade",
          skillClass: SkillClass.wits),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Stealth",
          skillClass: SkillClass.wits),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Scan",
          skillClass: SkillClass.wits),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Explore",
          skillClass: SkillClass.wits),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Riddle",
          skillClass: SkillClass.wits),
      Skill(
          isFavored: false,
          pips: 0,
          name: "Lore",
          skillClass: SkillClass.wits)
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