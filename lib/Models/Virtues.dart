import 'package:objectbox/objectbox.dart';

import 'Character.dart';

@Entity()
class Virtue {
  @Id()
  int id;

  @Property()
  var character = ToOne<Character>();

  @Property()
  String name;

  @Property()
  String note;

  Virtue({
    this.id = 0,
    this.name = '',
    this.note = '',
    character,
  }){
    character = ToOne<Character>();
  }

}