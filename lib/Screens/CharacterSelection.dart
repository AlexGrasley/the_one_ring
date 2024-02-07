import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Models/Character.dart';
import '../Repositories/CharacterRepository.dart';

final characterRepositoryProvider = FutureProvider.autoDispose<List<Character>>((ref) async {
  final characterRepo = await CharacterRepository.getInstance();
  return characterRepo.getAllCharacters();
});


class CharacterList extends ConsumerWidget {
  const CharacterList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final asyncCharacters = ref.watch(characterRepositoryProvider);

    return asyncCharacters.when(
        data: (characters) {
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColorDark,
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColorDark,
              title: const Text("Character Selection", style: TextStyle(color: Colors.blueGrey)),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                await ref.refresh(characterRepositoryProvider.future);
              },
              child: ListView.builder(
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.transparent,
                    shadowColor: Colors.blueGrey,
                    child: ListTile(
                        title: Text(
                          characters[index].name,
                          style: const TextStyle(color: Colors.white)),
                        subtitle: Text(
                          "${characters[index].heroicCulture} - ${characters[index].calling}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        onTap: () => Navigator
                            .popAndPushNamed(
                              context,
                              '/viewCharacter',
                              arguments: characters[index])
                            .then((value) =>
                              ref.refresh(characterRepositoryProvider))
                      // Other properties of your character
                      // e.g., subtitle: Text(characters[index].powerLevel),
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blueGrey,
              foregroundColor: Colors.white,
              onPressed: () => {
                Navigator
                    .popAndPushNamed(
                      context,
                      '/updateCharacter',
                      arguments: Character())
                    .then((value) =>
                      ref.refresh(characterRepositoryProvider))
              },
              child: const Text("+", style: TextStyle(fontSize: 38)),
            ),
          );
        },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text(error.toString())
    );
  }
}