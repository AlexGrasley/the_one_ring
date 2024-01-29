import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_one_ring/Repositories/CharacterRepository.dart';

void main() {
  runApp(const ProviderScope(child: TheOneRing()));
  CharacterRepository().init();
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
      home: const Scaffold(),
    );
  }
}


