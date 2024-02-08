import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

import '../Models/Armour.dart';
import 'ArmourCard.dart';

class ArmourCarousel extends StatelessWidget {
  const ArmourCarousel({
    super.key,
    required this.armour,
  });

  final ToMany<Armour> armour;

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
      items: armour.map((entry) {
        return Builder(builder: (BuildContext context){
          return ArmourCard(
              armour: entry,
              showDice: false,
              rollDice: (c, a) => {}
          );
        });
      }).toList(),
    );
  }
}