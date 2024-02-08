import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_one_ring/Helpers/HandDrawnDivider.dart';
import 'package:the_one_ring/Screens/CombatDataForm.dart';

import '../Helpers/Utilities.dart';
import '../Models/Character.dart';
import '../Models/Weapon.dart';

class WeaponCard extends ConsumerStatefulWidget{
  WeaponCard({required this.weapon,this.showDice = true, this.rollDice, super.key}){
    rollDice = (d,c) => {};
  }

  final Weapon weapon;
  final bool showDice;
  Function(Weapon, Character)? rollDice;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeaponCardState();
}

class _WeaponCardState extends ConsumerState<WeaponCard> with SingleTickerProviderStateMixin{

  bool _flipped = false;
  AnimationController? _controller;
  Animation<double>? _frontRotation;
  Animation<double>? _backRotation;
  Animation<double>? _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _frontRotation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: pi / 2),
        weight: 0.5,
      ),
      TweenSequenceItem(tween: ConstantTween(pi / 2), weight: 0.5),
    ]).animate(_controller!);

    _backRotation = TweenSequence([
      TweenSequenceItem(tween: ConstantTween(pi / 2), weight: 0.5),
      TweenSequenceItem(
        tween: Tween(begin: -pi / 2, end: 0.0),
        weight: 0.5,
      ),
    ]).animate(_controller!);

    _scale = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.8),
        weight: 0.5,
      )
    ]).animate(_controller!);
  }

  void _flipCard() {
    setState(() { _flipped = !_flipped; });
    _flipped ? _controller!.forward() : _controller!.reverse();
  }

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
      color: Colors.blueGrey,
      surfaceTintColor: Colors.black,
      shadowColor: Colors.blueGrey,
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,8,0,0),
            child: Text(
                widget.weapon.name,
                style: const TextStyle(color: Colors.white)
            ),
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
          InkWell(
            enableFeedback: false,
            splashColor: Colors.transparent,
            onTap: () => {
              _flipCard()
            },
            child: Stack(
                    children: [
                      _buildCardSide(
                        rotation: _frontRotation!,
                        child: _imageCard(),
                      ),
                      _buildCardSide(
                        rotation: _backRotation!,
                        child: _noteCard(),
                      ),
                    ],
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
                    onTap: () => {
                      widget.rollDice
                    },
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

  Widget _buildCardSide({
    required Animation<double> rotation,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (BuildContext context, Widget? child) {
        final isUnder = (ValueKey(_flipped) == ValueKey(rotation == _frontRotation));
        bool isOut = (rotation.value < (pi / 2));

        return IgnorePointer(
            ignoring: isUnder,
            child: ScaleTransition(
              scale: _scale!,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(rotation.value),
                child: child,
              ),
            )
        );
      },
      child: child,
    );
  }

  Container _imageCard() {
    return Container(
            margin: const EdgeInsets.fromLTRB(60,0,60,0),
            width: 150,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(3, 3), // changes position of shadow
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                image: AssetImage(widget.weapon.image),
              ),
            ),
          );
  }

  Widget _noteCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(60,0,60,0),
      width: 150,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 249, 240, 1),
          ),
            child: FittedBox(
              fit: BoxFit.fill,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.weapon.note,
                    style: const TextStyle(color: Colors.black54, fontSize: 8)),
                )
            )
        )
        ),
      );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

}