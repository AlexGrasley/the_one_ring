import 'dart:io';
import '../Models/Skills.dart';
import '../objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class SkillsRepository {
  // Make _singleton private and static
  static final SkillsRepository _singleton = SkillsRepository._internal();
  late final Store _store;
  late final Box<Skill> _skillsBox;

  // Use path provider to get app document directory
  Future<Directory> _getApplicationDocumentsDirectory() async {
    return getApplicationDocumentsDirectory();
  }

// In the constructor/init process, set the documents directory:
  SkillsRepository._internal() {
    _getApplicationDocumentsDirectory().then((Directory directory) {
      _store = Store(getObjectBoxModel(), directory: directory.path);
      _skillsBox = Box<Skill>(_store);
    });
  }

  // Public factory constructor. Returns the singleton instance.
  factory SkillsRepository() {
    return _singleton;
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
}