import 'package:objectbox/objectbox.dart';

@Entity()
class Reward {
  @Id()
  int id;

  @Property()
  String name;

  @Property()
  String note;

  @Property()
  int armourId;

  @Property()
  int weaponId;

  Reward({
    this.id = 0,
    this.name = '',
    this.note = '',
    this.armourId = 0,
    this.weaponId = 0,
  });
}