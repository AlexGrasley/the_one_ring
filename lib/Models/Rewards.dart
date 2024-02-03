import 'package:objectbox/objectbox.dart';

import 'Armour.dart';
import 'Character.dart';
import 'Weapon.dart';

@Entity()
class Reward {
  @Id()
  int id;

  @Property()
  var character = ToOne<Character>();

  @Property()
  String name;

  @Property()
  String note;

  @Property()
  var armour = ToOne<Armour>();

  @Property()
  var weapon = ToOne<Weapon>();

  Reward({
    this.id = 0,
    this.name = '',
    this.note = '',
    armour,
    weapon,
    character
  }){
    character = ToOne<Character>();
    armour = ToOne<Armour>();
    weapon = ToOne<Weapon>();
  }

  Reward copyWith({
    int? id,
    String? name,
    ToOne<Character>? character,
    ToOne<Armour>? armour,
    ToOne<Weapon>? weapon,
    String? note,
  }) {
    return Reward(
      id: id ?? this.id,
      name: name ?? this.name,
      character: character ?? this.character,
      armour: armour ?? this.armour,
      weapon: weapon ?? this.weapon,
      note: note ?? this.note
    );
  }

}