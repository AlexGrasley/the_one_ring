import 'package:objectbox/objectbox.dart';
import 'package:the_one_ring/Models/Character.dart';

import 'Rewards.dart';

@Entity()
class Weapon {
  @Id()
  int id;

  @Property()
  var character = ToOne<Character>();

  @Property()
  int damage;

  @Property()
  int injury;

  @Property()
  String name;

  @Property()
  String note;

  @Property()
  int load;

  @Property()
  int parry;

  @Property()
  int twoHandedInjuryModifier;

  @Property()
  String handedness;

  @Property()
  bool canPierce;

  @Property()
  bool isUsableByNaugrim;

  @Property()
  bool isUsableByHalfling;

  @Property()
  String proficiencyType;

  @Property()
  String weaponType;

  @Property()
  String image;

  @Backlink('weapon')
  var rewards = ToMany<Reward>();

  Weapon({
    this.id = 0,
    this.damage = 0,
    this.injury = 0,
    this.name = '',
    this.note = '',
    this.load = 0,
    this.parry = 0,
    this.twoHandedInjuryModifier = 0,
    this.handedness = "",
    this.canPierce = false,
    this.isUsableByHalfling = true,
    this.isUsableByNaugrim = true,
    this.proficiencyType = "",
    this.weaponType = "",
    this.image = "",
    character,
    rewards,
  }){
    character = ToOne<Character>();
    rewards = ToMany<Reward>();
  }

  Weapon copyWith({
    int? id,
    String? name,
    ToOne<Character>? character,
    int? damage,
    int? injury,
    String? note,
    int? load,
    int? parry,
    int? twoHandedInjuryModifier,
    String? handedness,
    bool? canPierce,
    bool? isUsableByNaugrim,
    bool? isUsableByHalfling,
    String? proficiencyType,
    String? weaponType,
    String? image,
  }) {
    return Weapon(
      id: id ?? this.id,
      name: name ?? this.name,
      character: character ?? this.character,
      damage: damage ?? this.damage,
      injury: injury ?? this.injury,
      note: note ?? this.note,
      load: load ?? this.load,
      parry: parry ?? this.parry,
      twoHandedInjuryModifier: twoHandedInjuryModifier ?? this.twoHandedInjuryModifier,
      handedness: handedness ?? this.handedness,
      canPierce: canPierce ?? this.canPierce,
      isUsableByHalfling: isUsableByHalfling ?? this.isUsableByHalfling,
      isUsableByNaugrim: isUsableByNaugrim ?? this.isUsableByNaugrim,
      proficiencyType: proficiencyType ?? this.proficiencyType,
      weaponType: weaponType ?? this.weaponType,
      image: image ?? this.image
    );
  }

}

enum WeaponProficiencyType{
  brawling,
  swords,
  spears,
  axes,
  bows
}

enum WeaponType {
  melee,
  ranged,
  meleeAndRanged,
}

enum Handedness {
  oneHanded,
  twoHanded,
  both,
}