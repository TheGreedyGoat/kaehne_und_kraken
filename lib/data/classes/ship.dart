import 'dart:convert';
import 'dart:math';

import 'package:kaehne_und_kraken/data/saves/json_loader.dart';

enum ShipSize { tiny, small, medium, large, huge }

class Ship {
  //=====BASE VALUES=====//

  String name;
  ShipSize size;
  late SPPool hullSP;
  late SPPool sailSP;
  late SPPool rudderSP;

  late ExpandableDiePool hullDice;

  //=====IMPLIED VALUES=====//

  double get sizeValue {
    return size.index == 0 ? 0.5 : size.index.toDouble();
  }

  Ship({
    required this.name,
    required this.size,
    required int hullSP,
    required int rudderSP,
    required int sailSP,
    int? crewSize,
  }) {
    this.hullSP = SPPool(hullSP);
    this.sailSP = SPPool(sailSP);
    this.rudderSP = SPPool(rudderSP);
    hullDice = ExpandableDiePool(faces: 4, maxDice: 4 * ((size.index) + 1));
  }

  Ship.jackdaw()
    : this(
        name: 'Jackdaw',
        size: ShipSize.medium,
        hullSP: 100,
        sailSP: 30,
        rudderSP: 30,
      );

  Ship.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String,
      size = ShipSize.values.firstWhere((element) {
        return element.toString() == '${json['size']}';
      }),
      hullSP = SPPool.fromJson(json['hullSP'] as Map<String, dynamic>),
      sailSP = SPPool.fromJson(json['sailSP'] as Map<String, dynamic>),
      rudderSP = SPPool.fromJson(json['rudderSP'] as Map<String, dynamic>);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'size': size.toString(),
      'hullSP': hullSP,
      'sailSP': sailSP,
      'rudderSP': rudderSP,
    };
  }

  void save() {}
  @override
  String toString() =>
      'Beware the mighty $name, it is ${size.name} in size and has ${hullSP.totalMax} max Structure Points!';
}

//TODO ========CREW==============//
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

  Map<String, int> toJson() => {
    'totalMax': totalMax,
    'currentMax': currentMax,
    'current': current,
  };

  SPPool.fromJson(Map<String, dynamic> poolMap) {
    int? totalMax = poolMap['totalMax'];
    int? currentMax = poolMap['currentMax'];
    int? current = poolMap['currentMax'];
    assert(
      totalMax != null && currentMax != null && current != null,
      'Null value in SP-Pool',
    );

    this.totalMax = totalMax!;
    this.currentMax = currentMax!;
    this.current = current!;
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
