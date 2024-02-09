import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_one_ring/Helpers/HandDrawnDivider.dart';

import '../Helpers/Utilities.dart';
import '../Models/Armour.dart';
import '../Models/Character.dart';

class ArmourCard extends ConsumerStatefulWidget
{
  ArmourCard({
    required this.armour,
    required this.character,
    this.showDice = true,
    this.rollDice,
    this.addArmour,
    this.removeArmour,
    super.key});

  final Armour armour;
  final Character character;
  final bool showDice;
  final Function(Armour, Character)? rollDice;
  final Function(Armour, Character)? addArmour;
  final Function(Armour, Character)? removeArmour;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeaponCardState();
}

class _WeaponCardState extends ConsumerState<ArmourCard> with SingleTickerProviderStateMixin
{

  bool _flipped = false;
  AnimationController? _controller;
  Animation<double>? _frontRotation;
  Animation<double>? _backRotation;
  Animation<double>? _scale;

  @override
  void initState()
  {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _frontRotation = TweenSequence(
    [
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: pi / 2),
        weight: 0.5,
      ),
      TweenSequenceItem(tween: ConstantTween(pi / 2), weight: 0.5),
    ]).animate(_controller!);

    _backRotation = TweenSequence(
    [
      TweenSequenceItem(tween: ConstantTween(pi / 2), weight: 0.5),
      TweenSequenceItem(
        tween: Tween(begin: -pi / 2, end: 0.0),
        weight: 0.5,
      ),
    ]).animate(_controller!);

    _scale = TweenSequence(
    [
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.8),
        weight: 0.5,
      )
    ]).animate(_controller!);

  }

  void _flipCard()
  {
    setState(()
    {
      _flipped = !_flipped;
    });

    _flipped ? _controller!.forward() : _controller!.reverse();
  }

  @override
  Widget build(BuildContext context)
  {

    String armourClass = Utilities.enumFromString(ArmourClass.values, widget.armour.armourClass).description;

    return Card(
      color: Colors.blueGrey.shade700,
      surfaceTintColor: Colors.black,
      shadowColor: Colors.grey,
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
        [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,8,0,0),
            child: Stack(
              alignment: Alignment.topCenter,
              fit: StackFit.loose,
              children:
              [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,8,0,0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                        widget.armour.name,
                        style: const TextStyle(color: Colors.white)
                    ),
                  ),
                ),
                widget.showDice?
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,8,0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: ()
                        {
                          removeArmour(context);
                        },
                        child: const Icon(FontAwesomeIcons.minus, color: Colors.white),
                      ),
                    ),
                  ) :
                  Container()
              ],
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
              children:
              [
                Column(
                  children:
                  [
                    if(widget.armour.armourClass == ArmourClass.shield.name)
                      ...[
                        const Text("Parry", style: TextStyle(color: Colors.white)),
                        Text(widget.armour.parry.toString(), style: const TextStyle(color: Colors.white))
                      ]
                    else
                      ...[
                        const Text("Protection", style: TextStyle(color: Colors.white)),
                        Text(widget.armour.protection.toString(), style: const TextStyle(color: Colors.white))
                      ]
                  ],
                ),
                const VerticalDivider( width: 10),
                Column(
                  children:
                  [
                    const Text("Load", style: TextStyle(color: Colors.white)),
                    Text(widget.armour.load.toString(), style: const TextStyle(color: Colors.white))
                  ],
                )
              ],
            ),
          ),
          InkWell(
            enableFeedback: false,
            splashColor: Colors.transparent,
            onTap: () =>
            {
               _flipCard()
            },
            child: Stack(
              children:
              [
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
            padding: const EdgeInsets.fromLTRB(15,20,15,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
              [
                Expanded(child: Text("Class: $armourClass", style: const TextStyle(color: Colors.white, fontSize: 12))),
                widget.showDice ?
                InkWell(
                  onTap: ()
                  {
                    widget.rollDice?.call(widget.armour, widget.character);
                  },
                  child: const Icon(FontAwesomeIcons.diceD20, color: Colors.white),
                ) :
                InkWell(
                  onTap: ()
                  {
                    widget.addArmour?.call(widget.armour, widget.character);
                    const snackBar = SnackBar(
                      content: Text('Armour added'),
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Icon(FontAwesomeIcons.squarePlus, color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void removeArmour(BuildContext context)
  {
  showDialog(
      context: context,
      builder: (BuildContext context)
      {
        return AlertDialog(
          backgroundColor: Colors.blueGrey.shade900,
          title: const Text('Confirm', style: TextStyle(color: Colors.white)),
          content: const Text('Are you sure you want to remove the armour?', style: TextStyle(color: Colors.white)),
          actions: <Widget>
          [
            TextButton(
                child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                onPressed: ()
                {
                  Navigator.of(context).pop();
                }),
            TextButton(
                child: const Text('Remove', style: TextStyle(color: Colors.red)),
                onPressed: ()
                {
                  widget.removeArmour?.call(widget.armour, widget.character);
                  const snackBar = SnackBar(
                    content: Text('Armour removed'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  Navigator.of(context).pop();
                })
          ],
        );
      });
  }

  Widget _buildCardSide({
    required Animation<double> rotation,
    required Widget child,
  })
  {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (BuildContext context, Widget? child)
      {
        final isUnder = (ValueKey(_flipped) == ValueKey(rotation == _frontRotation));

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

  Widget _imageCard()
  {
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
          image: AssetImage(widget.armour.image),
        ),
      ),
    );
  }

  Widget _noteCard()
  {
    return Container(
      margin: const EdgeInsets.fromLTRB(60,0,60,0),
      width: 150,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow:
        [
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
                        widget.armour.note,
                        style: const TextStyle(color: Colors.black54, fontSize: 8)),
                  )
              )
          )
      ),
    );
  }

  @override
  void dispose()
  {
    _controller!.dispose();
    super.dispose();
  }

}