import 'package:objectbox/objectbox.dart';

@Entity()
class Skill {
  @Id()
  int id;

  @Property()
  int pips;

  @Property()
  String name;

  @Property()
  bool isFavored;

  Skill({
    this.id = 0,
    this.pips = 0,
    this.name = '',
    this.isFavored = false,
  });
}