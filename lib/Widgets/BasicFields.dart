import 'package:flutter/material.dart';

import '../Models/Character.dart';
import '../StateNotifiers/CharacterStateNotifier.dart';
import 'TextFormInput.dart';

class BasicFields extends StatelessWidget
{
  const BasicFields({
    super.key,
    required this.context,
    required this.character,
    required this.characterFormNotifier,
  });

  final BuildContext context;
  final Character character;
  final CharacterStateNotifier characterFormNotifier;

  @override
  Widget build(BuildContext context)
  {
    return Column(
        children:
        [
          Row(
            children:
            [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormInput(
                    initialValue: character.name,
                    labelText: 'Name',
                    onChanged: (value) {
                      characterFormNotifier.updateName(value);
                    }
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormInput(
                    initialValue: character.heroicCulture,
                    labelText: 'Heroic Culture',
                    onChanged: (value) {
                      characterFormNotifier.updateHeroicCulture(value);
                    }
                  ),
                ),
              ),
            ],
          ),
          Row(
            children:
            [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormInput(
                    initialValue: character.culturalBlessing,
                    labelText: 'Cultural Blessing',
                    onChanged: (value) {
                      characterFormNotifier.updateCulturalBlessing(value);
                    }
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormInput(
                    initialValue: character.patron,
                    labelText: 'Patron',
                    onChanged: (value) {
                      characterFormNotifier.updatePatron(value);
                    }
                  ),
                ),
              ),
            ],
          ),
          Row(
            children:
            [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormInput(
                    initialValue: character.calling,
                    labelText: 'Calling',
                    onChanged: (value) {
                      characterFormNotifier.updateCalling(value);
                    }
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormInput(
                    initialValue: character.shadowPath,
                    labelText: 'Shadow Path',
                    onChanged: (value) {
                      characterFormNotifier.updateShadowPath(value);
                    }
                  ),
                ),
              ),
            ],
          ),
          Row(
            children:
            [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormInput(
                    initialValue: character.distinctiveFeatures,
                    labelText: 'Distinctive Features',
                    onChanged: (value) {
                      characterFormNotifier.updateDistinctiveFeatures(value);
                    }
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormInput(
                    initialValue: character.flaws,
                    labelText: 'Flaws',
                    onChanged: (value) {
                      characterFormNotifier.updateFlaws(value);
                    }
                  ),
                ),
              ),
            ],
          )
        ]);
  }
}