import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:the_one_ring/Repositories/SkillsRepository.dart';

import '../Models/Character.dart';
import '../Models/Skills.dart';

class ViewSkillForm extends StatelessWidget {
  final Character character;

  const ViewSkillForm({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: character.skills?.length,
      itemBuilder: (context, index) {
        final skill = character.skills?[index];
        return Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              // Favourite box
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: skill!.isFavored ? Colors.green : Colors.transparent,
                  border: Border.all(),
                ),
              ),
              // Name
              const SizedBox(width: 16),
              Text(skill.name),
              // Pips
              const SizedBox(width: 16),
              Row(
                children: List.generate(6, (pipIndex) {
                  // Generate pip boxes
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: pipIndex < skill.pips ? Colors.blue : Colors.transparent,
                      border: Border.all(),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}