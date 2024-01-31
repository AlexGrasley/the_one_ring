import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:the_one_ring/Models/CombatProficiencies.dart';
import 'package:the_one_ring/Models/Rewards.dart';
import 'package:the_one_ring/Models/Weapon.dart';
import 'Models/Armour.dart';
import 'Models/Character.dart';
import 'Models/Skills.dart';
import 'Models/Virtues.dart';
import 'objectbox.g.dart';
import 'package:synchronized/synchronized.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;
  late final Box<Character> characterBox;
  late final Box<Armour> armourBox;
  late final Box<CombatProficiencies> combatProficienciesBox;
  late final Box<Reward> rewardsBox;
  late final Box<Skill> skillsBox;
  late final Box<Virtue> virtuesBox;
  late final Box<Weapon> weaponsBox;

  ObjectBox._create(this.store){
    characterBox = Box<Character>(store);
    armourBox = Box<Armour>(store);
    combatProficienciesBox = Box<CombatProficiencies>(store);
    rewardsBox = Box<Reward>(store);
    skillsBox = Box<Skill>(store);
    virtuesBox = Box<Virtue>(store);
    weaponsBox = Box<Weapon>(store);
  }


  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Using the initializer in `objectbox.g.dart`
    final store = await openStore(directory: p.join(docsDir.path, "obx-theOneRing"));
    return ObjectBox._create(store);
  }

}