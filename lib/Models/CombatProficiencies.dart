import 'package:objectbox/objectbox.dart';

@Entity()
class CombatProficiencies {
  @Id()
  int id;

  @Property()
  int proficiency;

  @Property()
  String name;

  CombatProficiencies(this.name, {
    this.id = 0,
    this.proficiency = 0
  });

}