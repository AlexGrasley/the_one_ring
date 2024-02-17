
enum Cultures {
  bardings(description: "Bardings"),
  dwarves(description: "Dwarves of Durin's Folk"),
  elvesOfLindon(description: "Elves of Lindon"),
  hobbitsOfTheShire(description: "Hobbits of the Shire"),
  menOfBree(description: "Men of Bree"),
  rangersOfTheNorth(description: "Rangers of the North"),
  breeHobbits(description: "Bree-Hobbits"),
  highElvesOfRivendell(description: "High Elves of Rivendell"),
  beornings(description: "Beornings"),
  elvesOfMirkwood(description: "Elves of Mirkwood"),
  woodmenOfWilderland(description: "Woodmen of Wilderland");

  const Cultures({
    required this.description
  });

  final String description;
}

enum CulturalBlessings {
  stoutHearted(description: "Stout-Hearted"),
  redoubtable(description: "Redoubtable"),
  elvenSkill(description: "Elven-Skill"),
  hobbitSense(description: "Hobbit-Sense"),
  breeBlood(description: "Bree-Blood"),
  kingsOfMen(description: "Kings of Men"),
  elvenWise(description: "Elven-Wise"),
  furious(description: "Furious"),
  folkOfTheDusk(description: "Folk of the Dusk"),
  woodGoer(description: "Wood-Goer");

  const CulturalBlessings({
    required this.description
  });

  final String description;
}
