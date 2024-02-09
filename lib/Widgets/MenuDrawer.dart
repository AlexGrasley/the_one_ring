import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Models/Character.dart';

class MenuDrawer extends StatelessWidget
{
  MenuDrawer({super.key, this.character, this.deleteCharacter}){
    character ??= Character();
    deleteCharacter ??= (c) {};
  }

  Character? character;
  Function(Character)? deleteCharacter;

  @override
  Widget build(BuildContext context)
  {
    return Drawer(
      backgroundColor: Colors.black,
      elevation: 1,
      shadowColor: Colors.blueGrey.shade500,
      child: ListView(
        children: <Widget>
        [
          ListTile(
            visualDensity: VisualDensity.comfortable,
            contentPadding: const EdgeInsets.all(30),
            title: const Text("Character Selection", style: TextStyle(color: Colors.blueGrey)),
            trailing: const Icon(FontAwesomeIcons.angleRight, color: Colors.white),
            onTap: ()
            {
              Navigator.pushNamedAndRemoveUntil(context, "/", (Route<dynamic> route) => false);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Divider(height: 1, color: Colors.blueGrey.shade900),
          ),
          ListTile(
            visualDensity: VisualDensity.comfortable,
            contentPadding: const EdgeInsets.all(30),
            title: const Text("Delete Character", style: TextStyle(color: Colors.blueGrey)),
            trailing: const Icon(FontAwesomeIcons.xmark, color: Colors.red),
            onTap: ()
            {
              if(character != null)
              {
                deleteCharacterDialog(context, character!);
              }
            },
          ),
        ],
      ),
    );
  }

  void deleteCharacterDialog(BuildContext context, Character character)
  {
    showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return AlertDialog(
            backgroundColor: Colors.blueGrey.shade900,
            title: const Text('Confirm', style: TextStyle(color: Colors.white)),
            content: Text(
                'Are you sure you want to permanently delete ${character.name.isEmpty ? "character" : character.name}?',
                style: const TextStyle(color: Colors.white)
            ),
            actions: <Widget>
            [
              TextButton(
                  child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                  onPressed: ()
                  {
                    Navigator.of(context).pop();
                  }),
              TextButton(
                  child: const Text('Delete', style: TextStyle(color: Colors.red)),
                  onPressed: ()
                  {
                    deleteCharacter?.call(character);
                    SnackBar snackBar = SnackBar(
                      content: Text('${character.name.isEmpty ? "character" : character.name} deleted'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    Navigator.pushNamedAndRemoveUntil(context, "/", (Route<dynamic> route) => false);
                  })
            ],
          );
        });
  }

}

