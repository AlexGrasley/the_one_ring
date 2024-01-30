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
            appBar: AppBar(
              title: const Text("Character Selection"),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                await ref.refresh(characterRepositoryProvider.future);
              },
              child: ListView.builder(
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(characters[index].name),
                      onTap: () => Navigator
                          .pushNamed(
                            context,
                            '/viewCharacter',
                            arguments: characters[index])
                          .then((value) =>
                            ref.refresh(characterRepositoryProvider))
                    // Other properties of your character
                    // e.g., subtitle: Text(characters[index].powerLevel),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => {
                Navigator
                    .pushNamed(
                      context,
                      '/updateCharacter',
                      arguments: Character(""))
                    .then((value) =>
                      ref.refresh(characterRepositoryProvider))
              },
            ),
          );
        },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => const Text("something went wrong")
    );
  }
}