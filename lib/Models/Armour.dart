import 'package:objectbox/objectbox.dart';

@Entity()
class Armour {
  @Id()
  int id;

  @Property()
  int rating;

  @Property()
  String name;

  @Property()
  String note;

  Armour(this.name, {
    this.id = 0,
    this.rating = 0,
    this.note = ""
  });

}