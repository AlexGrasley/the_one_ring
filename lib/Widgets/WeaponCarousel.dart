
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../Models/Character.dart';
import '../Models/Weapon.dart';
import 'WeaponCard.dart';

class WeaponCarousel extends StatelessWidget
{
  WeaponCarousel({
    super.key,
    required this.weapons,
    required this.character,
    this.showDice = true,
    this.rollDice,
    this.addWeapon,
    this.removeWeapon,
  })
  {
  }

  final List<Weapon> weapons;
  final Character character;
  final bool showDice;
  final Function(Weapon, Character)? rollDice;
  final Function(Weapon, Character)? addWeapon;
  final Function(Weapon, Character)? removeWeapon;

  @override
  Widget build(BuildContext context)
  {
    return CarouselSlider(
      options:  CarouselOptions(
        autoPlay: false,
        height: 310,
        viewportFraction: 0.55,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
      ),
      items: weapons.map((entry)
      {
        return Builder(builder: (BuildContext context)
        {
          return WeaponCard(
              weapon: entry,
              character: character,
              showDice: showDice,
              rollDice: rollDice,
              addWeapon: addWeapon,
              removeWeapon: removeWeapon,
          );
        });
      }).toList(),
    );
  }
}