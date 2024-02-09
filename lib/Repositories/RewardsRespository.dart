import 'package:the_one_ring/main.dart';

import '../Models/Rewards.dart';
import '../objectbox.g.dart';

class RewardsRepository
{
  // Make _singleton private and static
  static final RewardsRepository _instance = RewardsRepository._internal();
  late final Store _store;
  late final Box<Reward> _rewardsBox;
  static bool hasBeenInitialized = false;

  // In the constructor/init process, set the documents directory:
  RewardsRepository._internal();

  Future<void> _init() async
  {
    _rewardsBox = objectBox.rewardsBox;
  }

  // In the constructor/init process, set the documents directory:
  RewardsRepository._privateConstructor();

  // Public factory constructor. Asynchronously creates and initializes an instance.
  static Future<RewardsRepository> getInstance() async
  {
    if(!hasBeenInitialized)
    {
      await _instance._init();
      hasBeenInitialized = true;
    }

    return _instance;
  }

  // Public factory constructor. Returns the singleton instance.
  factory RewardsRepository()
  {
    return _instance;
  }

  // CRUD operations.

  int addReward(Reward reward)
  {
    return _rewardsBox.put(reward);
  }

  List<Reward> getAllRewards()
  {
    return _rewardsBox.getAll();
  }

  Reward? getReward(int id)
  {
    return _rewardsBox.get(id);
  }

  bool removeReward(int id)
  {
    return _rewardsBox.remove(id);
  }

  int updateReward(Reward reward)
  {
    return _rewardsBox.put(reward);
  }
}