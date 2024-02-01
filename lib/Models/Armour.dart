import 'package:flutter/cupertino.dart';
import 'package:objectbox/objectbox.dart';

import 'Character.dart';

@Entity()
class Armour {
  @Id()
  int id;

  @Property()
  var character = ToOne<Character>();

  @Property()
  int rating;

  @Property()
  String name;

  @Property()
  String note;

  Armour({
    this.id = 0,
    this.name = "",
    this.rating = 0,
    this.note = "",
    character
  }){
    character = ToOne<Character>();
  }

  Armour copyWith({
    int? id,
    String? name,
    ToOne<Character>? character,
    int? rating,
    String? note,
  }) {
    return Armour(
        id: id ?? this.id,
        name: name ?? this.name,
        character: character ?? this.character,
        rating: rating ?? this.rating,
        note: note ?? this.note
    );
  }

}