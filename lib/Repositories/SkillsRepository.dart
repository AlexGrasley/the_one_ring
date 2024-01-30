import 'dart:io';
import '../Models/Skills.dart';
import '../objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class SkillsRepository {
  // Make _singleton private and static
  static final SkillsRepository _instance = SkillsRepository._privateConstructor();

  static bool hasBeenInitialized = false;

  late Store _store;
  late Box<Skill> _skillsBox;

  // Use path provider to get app document directory
  Future<Directory> _getApplicationDocumentsDirectory() async {
    return getApplicationDocumentsDirectory();
  }

  Future<void> _init() async {
    if(hasBeenInitialized){
      return;
    }
    final directory = await _getApplicationDocumentsDirectory();
    _store = Store(getObjectBoxModel(), directory: "${directory.path}/objectbox/skills");
    _skillsBox = Box<Skill>(_store);
    hasBeenInitialized = true;
    await fillSkillsBox();
  }

// In the constructor/init process, set the documents directory:
  SkillsRepository._privateConstructor();

  // Public factory constructor. Asynchronously creates and initializes an instance.
  static Future<SkillsRepository> getInstance() async {
    if(!hasBeenInitialized){
      await _instance._init();
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

  Skill? getSkill(int id) {
    return _skillsBox.get(id);
  }

  bool removeSkill(int id) {
    return _skillsBox.remove(id);
  }

  int updateSkill(Skill skill) {
    return _skillsBox.put(skill);
  }

  Future fillSkillsBox() async {
    SkillsRepository repo = await SkillsRepository.getInstance();
    repo.addSkill(
        Skill(
            isFavored: false,
            pips: 0,
            name: "Awe")
    );

    repo.addSkill(
        Skill(
            isFavored: false,
            pips: 0,
            name: "Athletics")
    );

    repo.addSkill(
        Skill(
            isFavored: false,
            pips: 0,
            name: "Awareness")
    );

    repo.addSkill(
        Skill(
            isFavored: false,
            pips: 0,
            name: "Hunting")
    );

    repo.addSkill(
        Skill(
            isFavored: false,
            pips: 0,
            name: "Song")
    );

    repo.addSkill(
        Skill(
            isFavored: false,
            pips: 0,
            name: "Craft")
    );

    repo.addSkill(
        Skill(
            isFavored: false,
            pips: 0,
            name: "Enhearten")
    );

    repo.addSkill(
        Skill(
            isFavored: false,
            pips: 0,
            name: "Travel")
    );

    repo.addSkill(
        Skill(
            isFavored: false,
            pips: 0,
            name: "Insight")
    );

    repo.addSkill(
        Skill(
            isFavored: false,
            pips: 0,
            name: "Healing")
    );

    repo.addSkill(
        Skill(
            isFavored: false,
            pips: 0,
            name: "Courtesy")
    );

    repo.addSkill(
        Skill(
            isFavored: false,
            pips: 0,
            name: "Battle")
    );

    repo.addSkill(
        Skill(
            isFavored: false,
            pips: 0,
            name: "Pursuade")
    );

    repo.addSkill(
        Skill(
            isFavored: false,
            pips: 0,
            name: "Stealth")
    );

    repo.addSkill(
        Skill(
            isFavored: false,
            pips: 0,
            name: "Scan")
    );

    repo.addSkill(
        Skill(
            isFavored: false,
            pips: 0,
            name: "Explore")
    );

    repo.addSkill(
        Skill(
            isFavored: false,
            pips: 0,
            name: "Riddle")
    );

    repo.addSkill(
        Skill(
            isFavored: false,
            pips: 0,
            name: "Lore")
    );
  }

}