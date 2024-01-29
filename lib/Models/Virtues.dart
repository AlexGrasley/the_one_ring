import 'package:objectbox/objectbox.dart';

@Entity()
class Virtue {
  @Id()
  int id;

  @Property()
  String name;

  @Property()
  String note;

  Virtue({
    this.id = 0,
    this.name = '',
    this.note = '',
  });
}