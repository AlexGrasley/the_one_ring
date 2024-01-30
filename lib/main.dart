import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_one_ring/Repositories/CharacterRepository.dart';
import 'package:the_one_ring/Repositories/SkillsRepository.dart';
import 'package:the_one_ring/Screens/CharacterFormView.dart';

import 'Models/Character.dart';
import 'Models/Skills.dart';
import 'Screens/CharacterSelection.dart';

void main() async {
  runApp(const ProviderScope(
      child: TheOneRing()));
}


class TheOneRing extends StatelessWidget {
  const TheOneRing({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'The One Ring',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CharacterList(),
      routes: {
        '/viewCharacter': (context) => CharacterView(ModalRoute.of(context)!.settings.arguments as Character, isReadOnly: true),
        '/updateCharacter': (context) => CharacterView(ModalRoute.of(context)!.settings.arguments as Character)
      }

    );
  }
}


