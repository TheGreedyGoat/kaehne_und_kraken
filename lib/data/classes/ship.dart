import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';
import 'package:kaehne_und_kraken/views/widgets/displays/formatted_text.dart';
import 'package:kaehne_und_kraken/views/widgets/inputs/number_input.dart';

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

  static const Map<ShipSize, int> defaultAgilityScore = {
    ShipSize.tiny: 14,
    ShipSize.small: 12,
    ShipSize.medium: 10,
    ShipSize.large: 6,
    ShipSize.huge: 4,
  };

  static const Map<ShipSize, String> defaultSipClass = {
    ShipSize.tiny: "Schaluppe",
    ShipSize.small: "Schoner",
    ShipSize.medium: "Brig",
    ShipSize.large: "Fregatte",
    ShipSize.huge: "Galeone",
  };

  //=====NARRATIVE VALUES=====//
  String? _className;
  String get className {
    _className ??= defaultSipClass[size];
    return _className!;
  }

  set className(String value) {
    _className = value;
  }
  //=====BASE VALUES=====//

  late String name;
  late ShipSize size;
  late StructurePoints hullSP;
  late StructurePoints sailSP;
  late StructurePoints rudderSP;

  late ExpandableDicePool hullDice;
  late CrewActions crewActions;

  AbilityScore? _agilityScore;
  AbilityScore get agilityScore {
    _agilityScore ??= AbilityScore(defaultAgilityScore[size]!);

    return _agilityScore!;
  }

  //=====IMPLIED VALUES=====//

  int get agilityMod => agilityScore.modifier;
  int get accelerationMod => agilityMod + 5;
  int get hexPerTurn => 6 - agilityMod;

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
    bool crewIncluded = false,
    HullDice hullDiceType = HullDice.d4,
    int? maxHullDice,
    int? currentHullDice,
    String? className,
  }) {
    this.hullSP = StructurePoints.create(hullSP);
    this.sailSP = StructurePoints.create(sailSP);
    this.rudderSP = StructurePoints.create(rudderSP);

    //====Hull Dice====//
    hullDice = ExpandableDicePool(
      faces: faces[hullDiceType]!,
      maxDice: maxHullDice ?? 4 * ((size.index) + 1),
      currentDice: currentHullDice ?? maxHullDice,
    );

    //====Crew====//
    crewActions = CrewActions.create(
      crewActionCapacity ?? defaultCrewActionCapacities[size]!,
    );

    //===AGILITY===//
    _agilityScore = AbilityScore(defaultAgilityScore[size]!);

    //===OTHER===//
    _className = className;
  }
  Ship.jackdaw()
    : this(
        name: 'Jackdaw',
        size: ShipSize.medium,
        hullSP: 100,
        sailSP: 30,
        rudderSP: 30,
      );
  Ship.queenAnne()
    : this(
        name: "Queen Anne's Revenge",
        size: ShipSize.huge,
        hullSP: 300,
        rudderSP: 100,
        sailSP: 100,
      );

  Ship.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    size = ShipSize.values.firstWhere((element) {
      return element.toString() == '${json['size']}';
    });
    hullSP = StructurePoints.fromJson(json['hullSP'] as Map<String, dynamic>);
    sailSP = StructurePoints.fromJson(json['sailSP'] as Map<String, dynamic>);
    rudderSP = StructurePoints.fromJson(
      json['rudderSP'] as Map<String, dynamic>,
    );
    crewActions = CrewActions.fromJson(
      json['crewActions'] as Map<String, dynamic>,
    );
    hullDice = json['hullDice'] != null
        ? ExpandableDicePool.fromJson(
            (json['hullDice'] as Map<String, dynamic>),
          )
        : ExpandableDicePool(faces: 4, maxDice: 10);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'size': size.toString(),
      'hullSP': hullSP,
      'sailSP': sailSP,
      'rudderSP': rudderSP,
      'crewActions': crewActions.toJson(),
      'hullDice': hullDice,
    };
  }

  void save() {
    ShipStorage.updateSaveFile();
  }

  @override
  String toString() => toJson().toString(); //'Beware the mighty $name, it is ${size.name} in size and has ${hullSP.totalMax} max Structure Points!';
}

class AbilityScore {
  int score;
  int get modifier {
    return ((score - 10).toDouble() * 0.5).floor();
  }

  AbilityScore(this.score);

  @override
  String toString() => '${TextFormatting.signedNumber(modifier)}($score)';
}
//======CLASS. VALUE POOL======//

/// Base class for a 3-Value Pool with
/// [current] value
/// the atm value [limit]
/// and the overall [capacity]
abstract class ValuePool {
  late int capacity, limit, current;

  /// Creates a value pool with a given `capcity`
  ValuePool.create(this.capacity) {
    limit = capacity;
    current = capacity;
  }

  ValuePool.fromJson(Map<String, dynamic> json)
    : capacity = json['capacity'],
      limit = json['max'] ?? json['capacity'],
      current = json['current'] ?? json['max'] ?? json['capacity'];

  Map<String, dynamic> toJson() {
    return {'capacity': capacity, 'max': limit, 'current:': current};
  }

  void reduce(int amount) {
    current -= min(amount, current);
  }

  void restore(int amount) {
    current = min(current + amount, limit);
  }

  @override
  String toString() => '$current / $limit / $capacity';
  //?=====DISPLAYS=====?//
  List<NumInputAction> inputActions(BuildContext context);
  Widget barWidget(double totalWidth) {
    return Container(
      width: totalWidth,
      height: 10.0,

      decoration: BoxDecoration(color: Colors.black),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            //===CURRENT===//
            width: totalWidth * (current / capacity),
            child: Container(decoration: BoxDecoration(color: Colors.green)),
          ),
          SizedBox(
            //===cMax===//
            width: totalWidth * ((limit - current) / capacity),
            child: Container(decoration: BoxDecoration(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

//======CLASS: STRUCTURE POINTS======//
class StructurePoints extends ValuePool {
  StructurePoints.create(super.capacity) : super.create();
  StructurePoints.fromJson(super.json) : super.fromJson();

  @override
  void reduce(int amount) {
    super.reduce(amount);
    limit -= (amount == 0 ? 0 : amount.toDouble() * 0.5).floor();
  }

  @override
  List<NumInputAction> inputActions(BuildContext context) {
    return [
      NumInputAction(
        label: Text('Schaden'),
        backgroundColor: Colors.redAccent,
        onPressed: (value) {
          print('reducing by $value');
          reduce(value);
        },
      ),
      NumInputAction(
        label: Text('Reparieren'),
        backgroundColor: Colors.lightGreen,
        onPressed: (value) {
          restore(value);
        },
      ),
    ];
  }
}

class CrewActions extends ValuePool {
  CrewActions.create(super.capacity) : super.create();
  CrewActions.fromJson(super.json) : super.fromJson();

  @override
  void reduce(int amount) {
    amount <= current ? super.reduce(amount) : {};
  }

  void losses(int amount) {
    limit -= min(amount, limit);
    current = min(current, limit);
  }

  void regain() {
    current = limit;
  }

  @override
  List<NumInputAction> inputActions(BuildContext context) {
    return [
      NumInputAction(
        label: TextFormatting.text('VERL', Formats.bodyMedium, context),
        backgroundColor: Colors.red,
        onPressed: (amount) {
          losses(amount);
        },
      ),
      NumInputAction(
        label: TextFormatting.text('VERW', Formats.bodyMedium, context),
        backgroundColor: Colors.yellow,
        onPressed: (amount) {
          reduce(amount);
        },
      ),
    ];
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
