import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuDrawer extends StatelessWidget{
  const MenuDrawer({super.key});


  @override
  Widget build(BuildContext context){
    return Drawer(
      
      backgroundColor: Colors.black,
      child: ListView(
        children: <Widget>[
          ListTile(
            title: const Text("Character Selection", style: TextStyle(color: Colors.blueGrey)),
            trailing: const Icon(FontAwesomeIcons.angleRight, color: Colors.blueGrey),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, "/");
            },
          ),
        ],
      ),
    );
  }

}

