import '../Helpers/Dice.dart';

class DiceResult
{
  final int d12;
  final int d6;
  final int greatSuccessCount;
  final RollStatus rollStatus;
  final RollResults rollResults;

  DiceResult({required this.d12, required this.d6, required this.greatSuccessCount,required this.rollStatus, required this.rollResults});
}