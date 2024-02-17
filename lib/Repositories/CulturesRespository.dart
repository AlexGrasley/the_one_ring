import '../Models/Culture.dart';

class CulturesRepository
{
  static Map<Cultures, CulturalBlessings> getCultureMap() {
    Map<Cultures, CulturalBlessings> cultureMap;

    cultureMap = {
      Cultures.bardings: CulturalBlessings.stoutHearted,
      Cultures.dwarves: CulturalBlessings.redoubtable,
      Cultures.elvesOfLindon : CulturalBlessings.elvenSkill,
      Cultures.hobbitsOfTheShire: CulturalBlessings.hobbitSense,
      Cultures.menOfBree: CulturalBlessings.breeBlood,
      Cultures.rangersOfTheNorth: CulturalBlessings.kingsOfMen,
      Cultures.breeHobbits: CulturalBlessings.breeBlood,
      Cultures.highElvesOfRivendell: CulturalBlessings.elvenWise,
      Cultures.beornings: CulturalBlessings.furious,
      Cultures.elvesOfMirkwood: CulturalBlessings.folkOfTheDusk,
      Cultures.woodmenOfWilderland: CulturalBlessings.woodGoer,
    };

    return cultureMap;
  }

}
