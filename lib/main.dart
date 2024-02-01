import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_one_ring/Helpers/DiamondShapePainter.dart';
import 'package:the_one_ring/Repositories/CharacterRepository.dart';
import 'package:the_one_ring/Repositories/SkillsRepository.dart';
import 'package:the_one_ring/Screens/CharacterFormView.dart';

import 'Models/Character.dart';
import 'Models/Skills.dart';
import 'ObjectBox.dart';
import 'Screens/CharacterSelection.dart';


late ObjectBox objectBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectBox = await ObjectBox.create();

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
        '/updateCharacter': (context) => CharacterView(ModalRoute.of(context)!.settings.arguments as Character, isReadOnly: false)
      }

    );
  }
}


