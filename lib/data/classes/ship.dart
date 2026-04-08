import 'dart:math';

enum ShipSize { tiny, small, medium, large, huge }

enum HullDice { d4, d6, d8 }

class Ship {
  static const Map<HullDice, int> faces = {
    HullDice.d4: 4,
    HullDice.d6: 6,
    HullDice.d8: 8,
  };
  //=====DEFAULT VALUES=====//
  static const Map<ShipSize, int> defaultCrewActionCapacities = {
    ShipSize.tiny: 1,
    ShipSize.small: 5,
    ShipSize.medium: 10,
    ShipSize.large: 20,
    ShipSize.huge: 30,
  };
  //=====BASE VALUES=====//

  late String name;
  late ShipSize size;
  late SPPool hullSP;
  late SPPool sailSP;
  late SPPool rudderSP;

  late ExpandableDicePool hullDice;
  late int crewActionsCapacity;
  late int crewActions;

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
    int? crewActionCapacity,
    int? crewSize,
    bool crewIncluded = false,
    HullDice hullDiceType = HullDice.d4,
    int? maxHullDice,
    int? currentHullDice,
  }) {
    this.hullSP = SPPool(hullSP);
    this.sailSP = SPPool(sailSP);
    this.rudderSP = SPPool(rudderSP);

    //====Hull Dice====//
    hullDice = ExpandableDicePool(
      faces: faces[hullDiceType]!,
      maxDice: maxHullDice ?? 4 * ((size.index) + 1),
      currentDice: currentHullDice ?? maxHullDice,
    );

    //====Crew====//
    crewActionsCapacity =
        crewActionCapacity ?? defaultCrewActionCapacities[size]!;
    crewActions = crewIncluded ? crewActionsCapacity : 0;
  }
  Ship.jackdaw()
    : this(
        name: 'Jackdaw',
        size: ShipSize.medium,
        hullSP: 100,
        sailSP: 30,
        rudderSP: 30,
      );

  Ship.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    size = ShipSize.values.firstWhere((element) {
      return element.toString() == '${json['size']}';
    });
    hullSP = SPPool.fromJson(json['hullSP'] as Map<String, dynamic>);
    sailSP = SPPool.fromJson(json['sailSP'] as Map<String, dynamic>);
    rudderSP = SPPool.fromJson(json['rudderSP'] as Map<String, dynamic>);
    crewActionsCapacity =
        json['crewActionCapacity'] ?? defaultCrewActionCapacities[size];
    crewActions = json['crewActions'] ?? crewActionsCapacity;
    hullDice = json['hullDice'] != null
        ? ExpandableDicePool.fromJson(
            (json['hullDice'] as Map<String, dynamic>),
          )
        : ExpandableDicePool(faces: 4, maxDice: 10);
  }

  //=====METHODS=====//
  bool useCrewActions(int amount) {
    if (crewActions < amount) return false;
    crewActions -= amount;
    return true;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'size': size.toString(),
      'hullSP': hullSP,
      'sailSP': sailSP,
      'rudderSP': rudderSP,
      'crewActionCapacity': crewActionsCapacity,
      'crewActions': crewActions,
      'hullDice': hullDice,
    };
  }

  void save() {}
  @override
  String toString() => this.toJson().toString(); //'Beware the mighty $name, it is ${size.name} in size and has ${hullSP.totalMax} max Structure Points!';
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

  @override
  String toString() => 'Total: $totalMax, current: $current';

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

class ExpandableDicePool {
  int faces = 6;
  int maxDice = 5;
  int currentDice = 5;
  ExpandableDicePool({
    required this.faces,
    required this.maxDice,
    int? currentDice,
  }) {
    currentDice = currentDice ?? maxDice;
    assert(
      currentDice >= 0 && currentDice <= maxDice,
      'Invalid amount of current Dice!',
    );
  }

  ExpandableDicePool.fromJson(Map<String, dynamic> json)
    : faces = json['faces'],
      maxDice = json['maxDice'],
      currentDice = json['currentDice'];

  int? roll() {
    if (currentDice > 0) {
      currentDice--;
      return Random().nextInt(currentDice + 1);
    }
    return null;
  }

  Map<String, int> toJson() => {
    'faces': faces,
    'maxDice': maxDice,
    'currentDice': currentDice,
  };

  @override
  String toString() => '$currentDice/$maxDice d$faces';
}
