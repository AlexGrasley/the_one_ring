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

  @Backlink('weapon')
  var rewards = ToMany<Reward>();

  Weapon({
    this.id = 0,
    this.damage = 0,
    this.injury = 0,
    this.name = '',
    this.note = '',
    this.load = 0,
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
  }) {
    return Weapon(
        id: id ?? this.id,
        name: name ?? this.name,
        character: character ?? this.character,
        damage: damage ?? this.damage,
        injury: injury ?? this.injury,
        note: note ?? this.note,
        load: load ?? this.load,
    );
  }

}