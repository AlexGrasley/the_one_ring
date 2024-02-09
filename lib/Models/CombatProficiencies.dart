import 'package:objectbox/objectbox.dart';

import 'Character.dart';

@Entity()
class CombatProficiencies
{
  @Id()
  int id;

  @Property()
  var character = ToOne<Character>();

  @Property()
  int proficiency;

  @Property()
  String name;

  CombatProficiencies({
    this.id = 0,
    this.name = "",
    this.proficiency = 0,
    character
  })
  {
    character = ToOne<Character>();
  }

}