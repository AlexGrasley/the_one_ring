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
  String armourClass;

  @Property()
  bool isUsableByNaugrim;

  @Property()
  bool isUsableByHalfling;

  @Backlink('armour')
  var rewards = ToMany<Reward>();

  @Property()
  String image;

  Armour({
    this.id = 0,
    this.name = "",
    this.protection = 0,
    this.load = 0,
    this.parry = 0,
    this.note = "",
    this.armourClass = "",
    this.image = "",
    this.isUsableByNaugrim = true,
    this.isUsableByHalfling = true,
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
    String? armourClass,
    String? image,
    bool? isUsableByNaugrim,
    bool? isUsableByHalfling,
  }) {
    return Armour(
      id: id ?? this.id,
      name: name ?? this.name,
      character: character ?? this.character,
      protection: protection ?? this.protection,
      load: load ?? this.load,
      parry: parry ?? this.parry,
      note: note ?? this.note,
      image: image ?? this.image,
      rewards: rewards ?? this.rewards,
      armourClass: armourClass ?? this.armourClass,
      isUsableByHalfling: isUsableByHalfling ?? this.isUsableByHalfling,
      isUsableByNaugrim: isUsableByNaugrim ?? this.isUsableByNaugrim,
    );
  }

}

enum ArmourClass {
  leather,
  mail,
  headgear,
  shield
}
