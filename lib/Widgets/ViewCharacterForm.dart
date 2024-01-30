import 'package:flutter/material.dart';
import '../Models/Character.dart';
import 'LabeledDivider.dart';

class ViewCharacteForm extends StatelessWidget {
  final Character character;

  const ViewCharacteForm({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          LabeledDivider(label: 'Name', value: character.name),
          const SizedBox(height: 10),
          LabeledDivider(label: 'Heroic Culture', value: character.heroicCulture),
          const SizedBox(height: 10),
          LabeledDivider(label: 'Cultural Blessing', value: character.culturalBlessing),
          const SizedBox(height: 10),
          LabeledDivider(label: 'Patron', value: character.patron),
          const SizedBox(height: 10),
          LabeledDivider(label: 'Calling', value: character.calling),
          const SizedBox(height: 10),
          LabeledDivider(label: 'Shadow Path', value: character.shadowPath),
        ],
      ),
    );
  }

}