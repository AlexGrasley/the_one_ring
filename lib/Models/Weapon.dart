import 'package:objectbox/objectbox.dart';

@Entity()
class Weapon {
  @Id()
  int id;

  @Property()
  int damage;

  @Property()
  int injury;

  @Property()
  String name;

  @Property()
  String note;

  Weapon({
    this.id = 0,
    this.damage = 0,
    this.injury = 0,
    this.name = '',
    this.note = '',
  });
}