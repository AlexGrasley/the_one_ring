import 'package:objectbox/objectbox.dart';

import 'Character.dart';

@Entity()
class Virtue
{
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

  Virtue copyWith({
    int? id,
    String? name,
    ToOne<Character>? character,
    String? note,
  })
  {
    return Virtue(
        id: id ?? this.id,
        name: name ?? this.name,
        character: character ?? this.character,
        note: note ?? this.note
    );
  }

}