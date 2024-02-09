import 'package:the_one_ring/main.dart';

import '../Models/Armour.dart';
import '../objectbox.g.dart';

class ArmourRepository
{
  // Make _singleton private and static
  static final ArmourRepository _instance = ArmourRepository._internal();
  late final Store _store;
  late final Box<Armour> _armourBox;
  static bool hasBeenInitialized = false;

  // In the constructor/init process, set the documents directory:
  ArmourRepository._internal() ;

  Future<void> _init() async
  {
    _armourBox = objectBox.armourBox;
  }

  // In the constructor/init process, set the documents directory:
  ArmourRepository._privateConstructor();

  // Public factory constructor. Asynchronously creates and initializes an instance.
  static Future<ArmourRepository> getInstance() async
  {
    if(!hasBeenInitialized)
    {
      await _instance._init();
      hasBeenInitialized = true;
    }

    return _instance;
  }

  // Public factory constructor. Returns the singleton instance.
  factory ArmourRepository()
  {
    return _instance;
  }

  List<Armour> getMasterArmourList()
  {
    return List<Armour>.from({
    Armour(
      name: "Leather Shirt",
      protection: 1,
      load: 2,
      armourClass: ArmourClass.leather.name,
      image: 'assets/leather_shirt.png',
      note: """
      The simplest suit of armour
      available, leather armour is made
      of layers of cured and hardened
      animal hide sewn together. It is
      ideal for hunting or travelling as
      it is lightweight and comfortable,
      especially compared to mail armour."""
    ),
    Armour(
      name: "Leather Corslet",
      protection: 2,
      load: 6,
      armourClass: ArmourClass.leather.name,
      image: 'assets/leather_corslet.png',
      note: """
      The simplest suit of armour
      available, leather armour is made
      of layers of cured and hardened
      animal hide sewn together. It is
      ideal for hunting or travelling as
      it is lightweight and comfortable,
      especially compared to mail armour."""
    ),
    Armour(
      name: "Mail Shirt",
      protection: 3,
      load: 9,
      armourClass: ArmourClass.mail.name,
      image: 'assets/mail_shirt.png',
      note: """
      Mail is the most effective type of
      armour encountered in Middle-earth
      at the end of the Third Age. These suits
      of close-fitting metal rings are created
      to protect from cutting and thrusting
      weapons. From the shining hauberks
      of Elven lords to the black mail of
      Orc-chieftains, mail armour appears
      in widely different qualities. Ancient
      coats of Dwarf-make, when found,
      are matchless and prized possessions."""
    ),
    Armour(
      name: "Coat of Mail",
      protection: 4,
      load: 12,
      armourClass: ArmourClass.mail.name,
      image: 'assets/coat_of_mail.png',
      note: """
      Mail is the most effective type of
      armour encountered in Middle-earth
      at the end of the Third Age. These suits
      of close-fitting metal rings are created
      to protect from cutting and thrusting
      weapons. From the shining hauberks
      of Elven lords to the black mail of
      Orc-chieftains, mail armour appears
      in widely different qualities. Ancient
      coats of Dwarf-make, when found,
      are matchless and prized possessions."""
    ),
    Armour(
      name: "Helm",
      protection: 1,
      load: 4,
      armourClass: ArmourClass.headgear.name,
      image: 'assets/helm.png',
      note: """
      Worn in battle or for ceremonial
      purposes, helms are usually made of
      leather or iron, but sometimes of more
      precious metals. The shape of a helm
      or its decoration is often distinctive, as
      it helps identify the wearer or their folk.
      More often than not, the protective
      features of the helm, especially noseguards or close-fitting cheek-guards,
      obscure the face and make it impossible
      to recognise the wearer otherwise."""
    ),
    Armour(
      name: "Buckler",
      protection: 0,
      parry: 1,
      load: 2,
      armourClass: ArmourClass.shield.name,
      image: 'assets/buckler.png',
      note: """
      Circular and made of wood
      reinforced by a protruding metal
      boss, bucklers are usually smaller
      and lighter than regular shields.

      Special Damage: Shield Thrust"""
    ),
    Armour(
      name: "Shield",
      protection: 0,
      parry: 2,
      load: 4,
      armourClass: ArmourClass.shield.name,
      image: 'assets/shield.png',
      note: """
      Round or oval, shields are made
      of several layers of wood, often
      reinforced by a large central
      iron boss, usually decorated and
      engraved. A regular shield offers
      good protection from arrows, and
      is very effective at close quarters.

      Special Damage: Shield Thrust"""
    ),
    Armour(
      name: "Great Shield",
      protection: 0,
      parry: 3,
      load: 6,
      armourClass: ArmourClass.shield.name,
      image: 'assets/great_shield.png',
      note: """
      Kite-shaped, round or barrel-shaped,
      these shields are carried by the
      sturdiest of warriors, and are used
      to carry back their bodies should
      they fall, but are considered too
      cumbersome and unwieldy by some."""
    ),
    });
  }

  // CRUD operations.

  int addArmour(Armour armour)
  {
    return _armourBox.put(armour);
  }

  List<Armour> getAllArmour()
  {
    return _armourBox.getAll();
  }

  Armour? getArmour(int id)
  {
    return _armourBox.get(id);
  }

  bool removeArmour(int id)
  {
    return _armourBox.remove(id);
  }

  int updateArmour(Armour armour)
  {
    return _armourBox.put(armour);
  }
}