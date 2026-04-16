import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/app_data.dart';
import 'package:kaehne_und_kraken/views/widgets/displays/formatted_text.dart';
import 'package:kaehne_und_kraken/views/widgets/inputs/number_input.dart';

enum ShipSize { tiny, small, medium, large, huge }

enum HullDice { d4, d6, d8 }

class Ship {
  bool isSaved = false;

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

  late AbilityScore? _agilityScore;
  AbilityScore get agilityScore {
    _agilityScore ??= AbilityScore(defaultAgilityScore[size]!);
    return _agilityScore!;
  }

  late AbilityScore? _crewMorale;
  AbilityScore get crewMorale {
    _crewMorale ??= AbilityScore(10);
    return _crewMorale!;
  }

  //=====IMPLIED VALUES=====//

  int get agilityMod => agilityScore.modifier;
  int get accelerationMod => agilityMod + 5;
  int get hexPerTurn => 6 - agilityMod;

  double get sizeValue {
    return size.index == 0 ? 0.5 : size.index.toDouble();
  }

  Ship.create({
    required this.name,
    required this.size,
    required int hullSP,
    required int sailSP,
    required int rudderSP,
    required HullDice hullDiceType,
    required int hullDiceAmt,
    bool save = true,
  }) {
    this.hullSP = StructurePoints.create(hullSP);
    this.sailSP = StructurePoints.create(sailSP);
    this.rudderSP = StructurePoints.create(rudderSP);

    //====Hull Dice====//
    hullDice = ExpandableDicePool(
      faces: faces[hullDiceType]!,
      maxDice: hullDiceAmt,
    );

    //====Crew====//
    crewActions = CrewActions.create(defaultCrewActionCapacities[size]!);

    //===AGILITY===//
    _agilityScore = AbilityScore(defaultAgilityScore[size]!);

    //===OTHER===//
    _crewMorale = AbilityScore(10);

    if (save) this.save();
  }

  Ship.jackdaw([bool save = true])
    : this.create(
        name: 'Jackdaw',
        size: ShipSize.medium,
        hullSP: 100,
        sailSP: 30,
        rudderSP: 30,
        hullDiceType: HullDice.d4,
        hullDiceAmt: 10,
        save: save,
      );
  Ship.queenAnne([bool save = true])
    : this.create(
        name: 'Queen annes Revenge',
        size: ShipSize.huge,
        hullSP: 350,
        sailSP: 100,
        rudderSP: 100,
        hullDiceType: HullDice.d8,
        hullDiceAmt: 15,
        save: save,
      );

  Map<String, dynamic> toJson() => {
    'name': name,
    'size': size.toString(),
    'hullSP': hullSP.toJson(),
    'sailSP': sailSP.toJson(),
    'rudderSP': rudderSP.toJson(),
    'hullDice': hullDice.toJson(),
    'crewActions': crewActions.toJson(),
    'agilityScore': agilityScore.score,
    'crewMorale': crewMorale.score,
  };

  Ship.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      size = ShipSize.values.firstWhere((e) => e.toString() == json['size']),
      hullSP = StructurePoints.fromJson(json['hullSP']),
      sailSP = StructurePoints.fromJson(json['sailSP']),
      rudderSP = StructurePoints.fromJson(json['rudderSP']),
      hullDice = ExpandableDicePool.fromJson(json['hullDice']),
      crewActions = CrewActions.fromJson(json['crewActions']),
      _agilityScore = AbilityScore(json['agilityScore']),
      _crewMorale = AbilityScore(json['crewMorale']),
      isSaved = true;

  void increaseDecreaseMorale(int amount) {
    crewMorale.score += amount;

    crewMorale.score.clamp(0, 20);
  }

  void save() {
    if (!isSaved) {
      AppData.addNewShip(this);
      isSaved = true;
    }
  }

  static void updateShips() {
    AppData.updateShipFile();
  }

  @override
  String toString() => toJson().toString(); //'Beware the mighty $name, it is ${size.name} in size and has ${hullSP.totalMax} max Structure Points!';
}

//?                /|___
//?              ///|   ))
//?            /////|   )))
//?          ///////|    )))
//?        /////////|     )))
//?      ///////////|     ))))
//?    /////////////|     )))
//?   //////////////|    )))
//? ////////////////|___)))
//?   ______________|________
//?   \                    /
//? ~~~~~~~~~~~~~~~~~~~~~~~~~~
//=====Class: Ability Score=====//

enum RollTypes { normal, advantage, disadvantage }

class AbilityScore {
  int score;
  Random die = Random();
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
  List<PopupMenuItem<Function>> get popup;

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

  void fullRestore() {
    limit = capacity;
    current = capacity;
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
  List<PopupMenuItem<Function>> get popup => <PopupMenuItem<Function>>[
    PopupMenuItem(value: fullRestore, child: Text('volle Reparatur')),
  ];

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
  List<PopupMenuItem<Function>> get popup => <PopupMenuItem<Function>>[
    PopupMenuItem(value: regain, child: Text('CA zurücksetzen')),
    PopupMenuItem(value: fullRestore, child: Text('Crew auffüllen')),
  ];

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
        label: TextFormatting.text('VERL', Formats.bodyMedium),
        backgroundColor: Colors.red,
        onPressed: (amount) {
          losses(amount);
        },
      ),
      NumInputAction(
        label: TextFormatting.text('VERW', Formats.bodyMedium),
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
