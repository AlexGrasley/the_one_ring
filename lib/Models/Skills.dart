import 'package:objectbox/objectbox.dart';

import 'Character.dart';

@Entity()
class Skill {
  @Id()
  int id;

  @Property()
  var character = ToOne<Character>();

  @Property()
  int pips;

  @Property()
  String name;

  @Property()
  bool isFavored;

  @Property()
  SkillClass skillClass;

  Skill({
    this.id = 0,
    this.pips = 0,
    this.name = '',
    this.isFavored = false,
    this.skillClass = SkillClass.strength,
    character,
  }) {
    character = ToOne<Character>();
  }

  Skill copyWith({
    int? id,
    String? name,
    ToOne<Character>? character,
    int? pips,
    bool? isFavored
  }) {
    return Skill(
        id: id ?? this.id,
        name: name ?? this.name,
        character: character ?? this.character,
        pips: pips ?? this.pips,
        isFavored: isFavored ?? this.isFavored
    );
  }
}

enum SkillClass {
  strength,
  heart,
  wits
}

