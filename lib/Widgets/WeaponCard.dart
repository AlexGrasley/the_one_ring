import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_one_ring/Helpers/HandDrawnDivider.dart';

import '../Helpers/Utilities.dart';
import '../Models/Weapon.dart';

class WeaponCard extends ConsumerStatefulWidget{
  const WeaponCard({required this.weapon,this.showDice = true, super.key});

  final Weapon weapon;
  final bool showDice;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeaponCardState();
}

class _WeaponCardState extends ConsumerState<WeaponCard>{

  @override
  Widget build(BuildContext context) {

    var handed = "";
    switch(Utilities.enumFromString(Handedness.values, widget.weapon.handedness)){
      case Handedness.oneHanded:
        handed = "One Handed";
        break;
      case Handedness.twoHanded:
        handed = "Two Handed";
        break;
      case Handedness.both:
        handed = "One or Two Handed";
        break;
    }

    return Card(
      color: Colors.transparent,
      shadowColor: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              widget.weapon.name,
              style: const TextStyle(color: Colors.white)
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8,8,8,0),
            child: HandDrawnDivider(thickness: 1),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text("Damage", style: TextStyle(color: Colors.white)),
                    Text(widget.weapon.damage.toString(), style: const TextStyle(color: Colors.white))
                  ],
                ),
                const VerticalDivider( width: 10),
                Column(
                  children: [
                    const Text("Injury", style: TextStyle(color: Colors.white)),
                    Text(widget.weapon.injury.toString(), style: const TextStyle(color: Colors.white))
                  ],
                ),
                const VerticalDivider( width: 10),
                Column(
                  children: [
                    const Text("Load", style: TextStyle(color: Colors.white)),
                    Text(widget.weapon.load.toString(), style: const TextStyle(color: Colors.white))
                  ],
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(30,0,30,0),
            child: Placeholder(
              fallbackHeight: 140,
              fallbackWidth: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15,15,15,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(handed, style: const TextStyle(color: Colors.white)),
                const Expanded(child: VerticalDivider(thickness: 3)),
                widget.showDice ?
                  InkWell(
                    onTap: () => {},
                    child: const Icon(FontAwesomeIcons.diceD20, color: Colors.white),
                  ) :
                  Container()
              ],
            ),
          )
        ],
      ),
    );
  }

}