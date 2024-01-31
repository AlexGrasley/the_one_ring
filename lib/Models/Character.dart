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
  var rewards = ToMany<Reward>();

  @Property()
  var virtues = ToMany<Virtue>();

  @Backlink('character')
  var skills = ToMany<Skill>();

  @Property()
  var weapons = ToMany<Weapon>();

  @Property()
  var armour = ToMany<Armour>();

  Character({
    this.id = 0,
    this.name = "",
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
    ToMany<Skill>? skills,
    ToMany<Reward>? rewards,
    ToMany<Armour>? armour,
    ToMany<Virtue>? virtues,
    ToMany<Weapon>? weapons
  }){
    this.skills = skills ?? ToMany<Skill>();
    this.rewards = rewards ?? ToMany<Reward>();
    this.armour = armour ?? ToMany<Armour>();
    this.virtues = virtues ?? ToMany<Virtue>();
    this.weapons = weapons ?? ToMany<Weapon>();
  }


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
    ToMany<Skill>? skills,
    ToMany<Reward>? rewards,
    ToMany<Virtue>? virtues,
    ToMany<Weapon>? weapons,
    ToMany<Armour>? armour
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
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

