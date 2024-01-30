import 'dart:core';
import 'package:objectbox/objectbox.dart';

import 'Armour.dart';
import 'Rewards.dart';
import 'Skills.dart';
import 'Virtues.dart';
import 'Weapon.dart';

@Entity()
class Character {
  @Id()
  int id;
  @Property()
  String name;

  @Property()
  String heroicCulture;

  @Property()
  String culturalBlessing;

  @Property()
  String patron;

  @Property()
  String calling;

  @Property()
  String shadowPath;

  @Property()
  String distinctiveFeatures;

  @Property()
  String flaws;

  @Property()
  String travellingGear;

  @Property()
  int age;

  @Property()
  int treasure;

  @Property()
  int strengthTn;

  @Property()
  int strengthRating;

  @Property()
  int endurance;

  @Property()
  int heartTn;

  @Property()
  int heartRating;

  @Property()
  int hope;

  @Property()
  int witsTn;

  @Property()
  int witsRating;

  @Property()
  int parry;

  @Property()
  int adventurePoint;

  @Property()
  int skillPoints;

  @Property()
  int fellowshipScore;

  @Property()
  int currentEndurance;

  @Property()
  int load;

  @Property()
  int fatigue;

  @Property()
  int currentHope;

  @Property()
  int shadow;

  @Property()
  int shadowScars;

  @Property()
  int valour;

  @Property()
  int wisdom;

  @Property()
  bool weary;

  @Property()
  bool miserable;

  @Property()
  bool wounded;

  @Property()
  List<Reward>? _rewards;

  List<Reward>? get rewards => _rewards ?? List<Reward>.empty(growable: true);

  set rewards(List<Reward>? value) {
    _rewards = value;
  }

  @Property()
  List<Virtue>? _virtues;

  List<Virtue>? get virtues => _virtues ?? List<Virtue>.empty(growable: true);

  set virtues(List<Virtue>? value) {
    _virtues = value;
  }

  @Property()
  List<Skill>? _skills;

  List<Skill>? get skills => _skills ?? List<Skill>.empty(growable: true);

  set skills(List<Skill>? value) {
    _skills = value;
  }

  @Property()
  List<Weapon>? _weapons;

  List<Weapon>? get weapons => _weapons ?? List<Weapon>.empty(growable: true);

  set weapons(List<Weapon>? value) {
    _weapons = value;
  }

  @Property()
  List<Armour>? _armour;

  List<Armour>? get armour => _armour ?? List<Armour>.empty(growable: true);

  set armour(List<Armour>? value) {
    _armour = value;
  }


  Character(this.name, {
    this.id = 0,
    this.heroicCulture = "",
    this.culturalBlessing = "",
    this.patron = "",
    this.calling = "",
    this.shadowPath = "",
    this.distinctiveFeatures = "",
    this.flaws = "",
    this.travellingGear = "",
    this.age = 0,
    this.treasure = 0,
    this.strengthTn = 0,
    this.strengthRating = 0,
    this.endurance = 0,
    this.heartTn = 0,
    this.heartRating = 0,
    this.hope = 0,
    this.witsTn = 0,
    this.witsRating = 0,
    this.parry = 0,
    this.adventurePoint = 0,
    this.skillPoints = 0,
    this.fellowshipScore = 0,
    this.currentEndurance = 0,
    this.load = 0,
    this.fatigue = 0,
    this.currentHope = 0,
    this.shadow = 0,
    this.shadowScars = 0,
    this.valour = 0,
    this.wisdom = 0,
    this.weary = false,
    this.miserable = false,
    this.wounded = false,
    List<Skill>? skills,
    List<Reward>? rewards,
    List<Virtue>? virtues,
    List<Weapon>? weapons,
    List<Armour>? armour,
  });

  Character copyWith({
    int? id,
    String? name,
    String? heroicCulture,
    String? culturalBlessing,
    String? patron,
    String? calling,
    String? shadowPath,
    String? distinctiveFeatures,
    String? flaws,
    String? travellingGear,
    int? age,
    int? treasure,
    int? strengthTn,
    int? strengthRating,
    int? endurance,
    int? heartTn,
    int? heartRating,
    int? hope,
    int? witsTn,
    int? witsRating,
    int? parry,
    int? adventurePoint,
    int? skillPoints,
    int? fellowshipScore,
    int? currentEndurance,
    int? load,
    int? fatigue,
    int? currentHope,
    int? shadow,
    int? shadowScars,
    int? valour,
    int? wisdom,
    bool? weary,
    bool? miserable,
    bool? wounded,
    List<Skill>? skills,
    List<Reward>? rewards,
    List<Virtue>? virtues,
    List<Weapon>? weapons,
    List<Armour>? armour
  }) {
    return Character(
      id: id ?? this.id,
      name ?? this.name,
      heroicCulture: heroicCulture ?? this.heroicCulture,
      culturalBlessing: culturalBlessing ?? this.culturalBlessing,
      patron: patron ?? this.patron,
      calling: calling ?? this.calling,
      shadowPath: shadowPath ?? this.shadowPath,
      distinctiveFeatures: distinctiveFeatures ?? this.distinctiveFeatures,
      flaws: flaws ?? this.flaws,
      travellingGear: travellingGear ?? this.travellingGear,
      age: age ?? this.age,
      treasure: treasure ?? this.treasure,
      strengthTn: strengthTn ?? this.strengthTn,
      strengthRating: strengthRating ?? this.strengthRating,
      endurance: endurance ?? this.endurance,
      heartTn: heartTn ?? this.heartTn,
      heartRating: heartRating ?? this.heartRating,
      hope: hope ?? this.hope,
      witsTn: witsTn ?? this.witsTn,
      witsRating: witsRating ?? this.witsRating,
      parry: parry ?? this.parry,
      adventurePoint: adventurePoint ?? this.adventurePoint,
      skillPoints: skillPoints ?? this.skillPoints,
      fellowshipScore: fellowshipScore ?? this.fellowshipScore,
      currentEndurance: currentEndurance ?? this.currentEndurance,
      load: load ?? this.load,
      fatigue: fatigue ?? this.fatigue,
      currentHope: currentHope ?? this.currentHope,
      shadow: shadow ?? this.shadow,
      shadowScars: shadowScars ?? this.shadowScars,
      valour: valour ?? this.valour,
      wisdom: wisdom ?? this.wisdom,
      skills: skills ?? this.skills,
      rewards: rewards ?? this.rewards,
      virtues: virtues ?? this.virtues,
      weapons: weapons ?? this.weapons,
      armour: armour ?? this.armour
    );
  }


}

