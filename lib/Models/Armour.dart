import 'package:flutter/cupertino.dart';
import 'package:objectbox/objectbox.dart';

import 'Character.dart';
import 'Rewards.dart';

@Entity()
class Armour {
  @Id()
  int id;

  @Property()
  var character = ToOne<Character>();

  @Property()
  int protection;

  @Property()
  int load;

  @Property()
  int parry;

  @Property()
  String name;

  @Property()
  String note;

  @Property()
  String armourType;

  @Backlink('armour')
  var rewards = ToMany<Reward>();

  Armour({
    this.id = 0,
    this.name = "",
    this.protection = 0,
    this.load = 0,
    this.parry = 0,
    this.note = "",
    this.armourType = "",
    character,
    rewards
  }){
    character = ToOne<Character>();
    rewards = ToMany<Reward>();
  }

  Armour copyWith({
    int? id,
    String? name,
    ToOne<Character>? character,
    int? protection,
    int? load,
    int? parry,
    String? note,
    ToMany<Reward>? rewards,
    String? armourType,
  }) {
    return Armour(
        id: id ?? this.id,
        name: name ?? this.name,
        character: character ?? this.character,
        protection: protection ?? this.protection,
        load: load ?? this.load,
        parry: parry ?? this.parry,
        note: note ?? this.note,
        rewards: rewards ?? this.rewards,
        armourType: armourType ?? this.armourType
    );
  }

}

enum ArmourType {
  armour,
  helm,
  shield
}
