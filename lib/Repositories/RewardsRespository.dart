import 'dart:io';
import '../Models/Rewards.dart';
import '../objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class RewardsRepository {
  // Make _singleton private and static
  static final RewardsRepository _singleton = RewardsRepository._internal();
  late final Store _store;
  late final Box<Reward> _rewardsBox;

  // Use path provider to get app document directory
  Future<Directory> _getApplicationDocumentsDirectory() async {
    return getApplicationDocumentsDirectory();
  }

// In the constructor/init process, set the documents directory:
  RewardsRepository._internal() {
    _getApplicationDocumentsDirectory().then((Directory directory) {
      _store = Store(getObjectBoxModel(), directory: directory.path);
      _rewardsBox = Box<Reward>(_store);
    });
  }

  // Public factory constructor. Returns the singleton instance.
  factory RewardsRepository() {
    return _singleton;
  }

  // CRUD operations.

  int addReward(Reward reward) {
    return _rewardsBox.put(reward);
  }

  List<Reward> getAllRewards() {
    return _rewardsBox.getAll();
  }

  Reward? getReward(int id) {
    return _rewardsBox.get(id);
  }

  bool removeReward(int id) {
    return _rewardsBox.remove(id);
  }

  int updateReward(Reward reward) {
    return _rewardsBox.put(reward);
  }
}