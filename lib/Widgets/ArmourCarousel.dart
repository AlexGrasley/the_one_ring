import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../Models/Armour.dart';
import '../Models/Character.dart';
import 'ArmourCard.dart';

class ArmourCarousel extends StatelessWidget
{
  const ArmourCarousel({
    super.key,
    required this.armour,
    required this.character,
    this.showDice = true,
    this.rollDice,
    this.addArmour,
    this.removeArmour,
  });

  final List<Armour> armour;
  final Character character;
  final bool showDice;
  final Function(Armour, Character)? rollDice;
  final Function(Armour, Character)? addArmour;
  final Function(Armour, Character)? removeArmour;

  @override
  Widget build(BuildContext context)
  {
    return CarouselSlider(
      options:  CarouselOptions(
        autoPlay: false,
        height: 315,
        viewportFraction: 0.55,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        enlargeFactor: 0.15,
      ),
      items: armour.map((entry)
      {
        return Builder(builder: (BuildContext context)
        {
          return ArmourCard(
            armour: entry,
            character: character,
            showDice: showDice,
            rollDice: rollDice,
            addArmour: addArmour,
            removeArmour: removeArmour,
          );
        });
      }).toList(),
    );
  }
}