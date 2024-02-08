import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../Models/Weapon.dart';
import '../objectbox.g.dart';
import 'WeaponCard.dart';

class WeaponCarousel extends StatelessWidget {
  const WeaponCarousel({
    super.key,
    required this.weapons,
  });

  final ToMany<Weapon> weapons;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options:  CarouselOptions(
        autoPlay: false,
        height: 300,
        viewportFraction: 0.55,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
      ),
      items: weapons.map((entry) {
        return Builder(builder: (BuildContext context){
          return WeaponCard(
              weapon: entry,
              rollDice: (w, c) => {}
          );
        });
      }).toList(),
    );
  }
}