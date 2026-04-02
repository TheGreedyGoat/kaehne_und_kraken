import 'dart:math';

enum ShipSize { tiny, small, medium, large, huge }

class Ship {
  String name;
  ShipSize size;
  double get sizeValue {
    return size.index == 0 ? 0.5 : size.index.toDouble();
  }

  late AbilityScore agility;
  int get accelerationBonus => agility.modifier + 5;

  int get turnRadius => 6 - agility.modifier;
  late Crew crew;

  late SPPool hullSP;
  late SPPool sailSP;
  late SPPool rudderSP;

  late ExpandableDiePool hullDice;

  Ship({
    required this.name,
    required this.size,
    required int hullSP,
    required int rudderSP,
    required int sailSP,
    int? agilityScore,
    int? crewSize,
  }) {
    this.hullSP = SPPool(hullSP);
    this.sailSP = SPPool(sailSP);
    this.rudderSP = SPPool(rudderSP);
    agility = AbilityScore(agilityScore ?? 10);
    crew = Crew(crewSize: crewSize ?? 0, ship: this);
    hullDice = ExpandableDiePool(faces: 4, maxDice: 4 * ((size.index) + 1));
  }
}

class Crew {
  Ship ship;
  int crewSize;
  int get maxCrewActions {
    return (crewSize.toDouble() / (ship.size == ShipSize.tiny ? 4.0 : 8.0))
        .floor();
  }

  late int currentCrewActions;

  AbilityScore morale = AbilityScore(10);

  Crew({required this.ship, required this.crewSize}) {
    currentCrewActions = maxCrewActions;
  }
}

class AbilityScore {
  int score;
  int get modifier {
    return ((score - 10).toDouble() * 0.5).floor();
  }

  AbilityScore(this.score);
}

class SPPool {
  int totalMax = 20;
  int currentMax = 20;
  int current = 20;
  SPPool(int maxSP) {
    totalMax = maxSP;
    currentMax = maxSP;
    current = maxSP;
  }

  void takeDamage(int damage) {
    current -= damage;
    currentMax -= (damage.toDouble() * 0.5).floor();
  }

  void repairParially() {
    current = currentMax;
  }

  void repairFully() {
    current = totalMax;
    currentMax = totalMax;
  }
}

class ExpandableDiePool {
  int faces = 6;
  int maxDice = 5;
  late int currentDice;
  ExpandableDiePool({required this.faces, required this.maxDice}) {
    currentDice = maxDice;
  }

  int? roll() {
    if (currentDice > 0) {
      currentDice--;
      return Random().nextInt(currentDice + 1);
    }
    return null;
  }
}
