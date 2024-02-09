import 'package:the_one_ring/main.dart';
import '../Models/Weapon.dart';
import '../objectbox.g.dart';

class WeaponRepository
{
  // Make _singleton private and static
  static final WeaponRepository _instance = WeaponRepository._internal();
  late final Store _store;
  late final Box<Weapon> _weaponBox;
  static bool hasBeenInitialized = false;

// In the constructor/init process, set the documents directory:
  WeaponRepository._internal();

  Future<void> _init() async
  {
    _weaponBox = objectBox.weaponsBox;
  }

// In the constructor/init process, set the documents directory:
  WeaponRepository._privateConstructor();

  // Public factory constructor. Asynchronously creates and initializes an instance.
  static Future<WeaponRepository> getInstance() async
  {
    if(!hasBeenInitialized)
    {
      await _instance._init();
      hasBeenInitialized = true;
    }

    return _instance;
  }

  // Public factory constructor. Returns the singleton instance.
  factory WeaponRepository()
  {
    return _instance;
  }

  List<Weapon> getMasterWeaponsList()
  {
    return List<Weapon>.from(
    {
      Weapon(
        name: "Dagger",
        damage: 2,
        injury: 14,
        load: 0,
        proficiencyType: WeaponProficiencyType.brawling.name,
        handedness: Handedness.oneHanded.name,
        weaponType: WeaponType.melee.name,
        parry: 1,
        isUsableByNaugrim: true,
        isUsableByHalfling: true,
        image: 'assets/dagger.png',
        note: """
One-handed blades have a range of
uses, from skinning animals to settling
disputes among brutes. Daggers and
knives are very common, and in
the wild areas of the land, no-one
is found without one in their belt.

Combat Proficiency: Brawling

Special Damage: Heavy Blow, Fend Off
        """
      ),
      Weapon(
        name: "Cudgel",
        damage: 3,
        injury: 12,
        load: 0,
        proficiencyType: WeaponProficiencyType.brawling.name,
        handedness: Handedness.oneHanded.name,
        weaponType: WeaponType.melee.name,
        parry: 1,
        isUsableByNaugrim: true,
        isUsableByHalfling: true,
        image: 'assets/cudgel.png',
        note: """
A cudgel is any bashing implement
used with one hand, like a
small club or short staff.

Combat Proficiency: Brawling

Special Damage: Heavy Blow, Fend Off
        """
      ),
      Weapon(
        name: "Club",
        damage: 4,
        injury: 14,
        load: 1,
        proficiencyType: WeaponProficiencyType.brawling.name,
        handedness: Handedness.oneHanded.name,
        weaponType: WeaponType.melee.name,
        parry: 1,
        isUsableByNaugrim: true,
        isUsableByHalfling: true,
        image: 'assets/club.png',
        note: """
A club is probably the simplest
form of weapon. It may consist of
a crude, heavy piece of wood, a
nasty instrument reinforced with
iron, or an elaborately-carved staff
used also as a symbol of status.

Combat Proficiency: Brawling

Special Damage: Heavy Blow, Fend Off
        """
      ),
      Weapon(
        name: "Short Sword",
        damage: 4,
        injury: 16,
        load: 1,
        proficiencyType: WeaponProficiencyType.swords.name,
        handedness: Handedness.oneHanded.name,
        weaponType: WeaponType.melee.name,
        parry: 2,
        isUsableByNaugrim: true,
        isUsableByHalfling: true,
        image: 'assets/short_sword.png',
        note: """
Large daggers and knives,
or smaller swords created for
close-quarters combat.

Combat Proficiency: Swords

Special Damage: Heavy Blow, Fend Off, 
Pierce
        """
      ),
      Weapon(
        name: "Sword",
        damage: 4,
        injury: 16,
        load: 2,
        proficiencyType: WeaponProficiencyType.swords.name,
        handedness: Handedness.oneHanded.name,
        weaponType: WeaponType.melee.name,
        parry: 2,
        isUsableByNaugrim: true,
        isUsableByHalfling: false,
        image: 'assets/sword.png',
        note: """
A straight-bladed, two-edged sword,
wielded in one hand to hew or thrust.
This is the most common type of sword.

Combat Proficiency: Swords

Special Damage: Heavy Blow, Fend Off, 
Pierce
        """
      ),
      Weapon(
        name: "Long Sword",
        damage: 5,
        injury: 16,
        twoHandedInjuryModifier: 2,
        load: 3,
        proficiencyType: WeaponProficiencyType.swords.name,
        handedness: Handedness.both.name,
        weaponType: WeaponType.melee.name,
        parry: 2,
        isUsableByNaugrim: true,
        isUsableByHalfling: false,
        image: 'assets/long_sword.png',
        note: """
Only superior smiths can produce
longer blades. These wonderful Elven
and Dwarven weapons, and the keen
blades forged from strange metals by
the Men of the West, are often known
as long swords. A long sword may
either be wielded with one hand, or
used to hack and sweep with two hands.

Combat Proficiency: Swords

Notes: Can be used 1- or 2-handed

Special Damage: Heavy Blow, Fend Off, 
Pierce
        """
      ),
      Weapon(
        name: "Short Spear",
        damage: 3,
        injury: 14,
        twoHandedInjuryModifier: 0,
        load: 2,
        proficiencyType: WeaponProficiencyType.spears.name,
        handedness: Handedness.oneHanded.name,
        weaponType: WeaponType.meleeAndRanged.name,
        parry: 3,
        isUsableByNaugrim: true,
        isUsableByHalfling: true,
        image: 'assets/short_spear.png',
        note: """
Approximately six feet in length,
a spear can be hurled as a javelin,
or deftly thrust with one hand.

Combat Proficiency: Spears

Notes: Can be thrown

Special Damage: Heavy Blow, Fend Off, 
Pierce
        """
      ),
      Weapon(
        name: "Spear",
        damage: 4,
        injury: 14,
        twoHandedInjuryModifier: 2,
        load: 3,
        proficiencyType: WeaponProficiencyType.spears.name,
        handedness: Handedness.both.name,
        weaponType: WeaponType.meleeAndRanged.name,
        parry: 3,
        isUsableByNaugrim: true,
        isUsableByHalfling: true,
        image: 'assets/spear.png',
        note: """
Maybe the most versatile weapon
of all, a spear can be thrown,
or used with one or two hands.

Combat Proficiency: Spears

Notes: Can be used 1- or 2-handed. 
Can be thrown.

Special Damage: Heavy Blow, Fend Off, 
Pierce
        """
      ),
      Weapon(
        name: "Great Spear",
        damage: 5,
        injury: 16,
        twoHandedInjuryModifier: 0,
        load: 4,
        proficiencyType: WeaponProficiencyType.spears.name,
        handedness: Handedness.twoHanded.name,
        weaponType: WeaponType.melee.name,
        parry: 3,
        isUsableByNaugrim: false,
        isUsableByHalfling: false,
        image: 'assets/great_spear.png',
        note: """
With a shaft longer than any
other spear, a great spear cannot
be used as a ranged weapon, and
must be wielded with two hands.

Combat Proficiency: Spears

Notes: 2-handed

Special Damage: Heavy Blow, Fend Off, 
Pierce
        """
      ),
      Weapon(
        name: "Axe",
        damage: 5,
        injury: 18,
        twoHandedInjuryModifier: 0,
        load: 2,
        proficiencyType: WeaponProficiencyType.axes.name,
        handedness: Handedness.oneHanded.name,
        weaponType: WeaponType.melee.name,
        parry: 2,
        isUsableByNaugrim: true,
        isUsableByHalfling: true,
        image: 'assets/axe.png',
        note: """
A fighting variation on the common
woodcutting tool, axes hang from
the belt of many adventurers
raised in or near forests.

Combat Proficiency: Axes

Special Damage: Heavy Blow, Fend Off
        """
      ),
      Weapon(
        name: "Long-hafted Axe",
        damage: 6,
        injury: 18,
        twoHandedInjuryModifier: 2,
        load: 3,
        proficiencyType: WeaponProficiencyType.axes.name,
        handedness: Handedness.both.name,
        weaponType: WeaponType.melee.name,
        parry: 1,
        isUsableByNaugrim: true,
        isUsableByHalfling: false,
        image: 'assets/long_hafted_axe.png',
        note: """
One-handed blades have a range of
uses, from skinning animals to settling
disputes among brutes. Daggers and
knives are very common, and in
the wild areas of the land, no-one
is found without one in their belt

Combat Proficiency: Brawling

Special Damage: Heavy Blow, Fend Off
        """
      ),
      Weapon(
        name: "Great Axe",
        damage: 7,
        injury: 20,
        twoHandedInjuryModifier: 0,
        load: 4,
        proficiencyType: WeaponProficiencyType.axes.name,
        handedness: Handedness.twoHanded.name,
        weaponType: WeaponType.melee.name,
        parry: 1,
        isUsableByNaugrim: true,
        isUsableByHalfling: false,
        image: 'assets/great_axe.png',
        note: """
The great axe is an impressive
weapon that can only be wielded
with two hands. Its heavy head can
leave both a deep dint on armour
as a club and cleave it as a sword.

Combat Proficiency: Axes

Notes: 2-handed

Special Damage: Heavy Blow, Fend Off
        """
      ),
      Weapon(
        name: "Mattock",
        damage: 7,
        injury: 18,
        twoHandedInjuryModifier: 0,
        load: 3,
        proficiencyType: WeaponProficiencyType.axes.name,
        handedness: Handedness.twoHanded.name,
        weaponType: WeaponType.melee.name,
        parry: 1,
        isUsableByNaugrim: true,
        isUsableByHalfling: false,
        image: 'assets/mattock.png',
        note: """
A heavy digging implement sporting a
curved head with a point on one side
and a spade-like blade on the other.
It was used to fearsome effect by the
Dwarves who followed Dáin Ironfoot
during the Battle of Five Armies.

Combat Proficiency: Axes

Notes: 2-handed

Special Damage: Heavy Blow, Fend Off
        """
      ),
      Weapon(
        name: "Bow",
        damage: 3,
        injury: 14,
        twoHandedInjuryModifier: 0,
        load: 2,
        proficiencyType: WeaponProficiencyType.bows.name,
        handedness: Handedness.twoHanded.name,
        weaponType: WeaponType.ranged.name,
        parry: 0,
        isUsableByNaugrim: true,
        isUsableByHalfling: true,
        image: 'assets/bow.png',
        note: """
The simple bow is not very different
from a hunting-bow. It never measures
more than five feet in length, so
as to be strung more quickly.

Combat Proficiency: Bows

Notes: Ranged weapon

Special Damage: Heavy Blow, Pierce
        """
      ),
      Weapon(
        name: "Great Bow",
        damage: 4,
        injury: 16,
        twoHandedInjuryModifier: 0,
        load: 4,
        proficiencyType: WeaponProficiencyType.bows.name,
        handedness: Handedness.twoHanded.name,
        weaponType: WeaponType.ranged.name,
        parry: 2,
        isUsableByNaugrim: false,
        isUsableByHalfling: false,
        image: 'assets/great_bow.png',
        note: """
As tall as a Man and offering
superior potency, a great bow can
only be used by warriors with the
height and stature to bend it fully.
An arrow from a great bow can
pierce the toughest of armour.

Combat Proficiency: Bows

Notes: Ranged weapon

Special Damage: Heavy Blow, Pierce
        """
      )
    });
  }

  // CRUD operations.

  int addArmour(Weapon weapon)
  {
    return _weaponBox.put(weapon);
  }

  List<Weapon> getAllWeapons()
  {
    return _weaponBox.getAll();
  }

  Weapon? getWeapon(int id)
  {
    return _weaponBox.get(id);
  }

  bool removeWeapon(int id)
  {
    return _weaponBox.remove(id);
  }

  int updateWeapon(Weapon weapon)
  {
    return _weaponBox.put(weapon);
  }
}