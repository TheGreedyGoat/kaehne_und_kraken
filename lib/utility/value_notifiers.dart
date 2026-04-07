import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:kaehne_und_kraken/data/saves/json_loader.dart';

final ValueNotifier<List<Widget>> rulesWidgetsNotifier = ValueNotifier(
  List.empty(),
);
final ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);

//?=====SHIP CREATION=====//

//===TITLE WIDGET===//
final ValueNotifier<String?> shipCreationNameNotifier = ValueNotifier(null);
final ValueNotifier<ShipSize?> shipCreationSizeNotifier = ValueNotifier(null);
//===DEFENSE WIDGET===//

final ValueNotifier<int?> shipCreationHullSPNotifier = ValueNotifier(null);
final ValueNotifier<int?> shipCreationSailSPNotifier = ValueNotifier(null);
final ValueNotifier<int?> shipCreationRudderSPNotifier = ValueNotifier(null);

class ShipStorage {
  static final ValueNotifier<List<Ship>> _notifier = ValueNotifier([]);

  static ValueNotifier<List<Ship>> get notifier => _notifier;
  static List<Ship> get saves => _notifier.value;
  static set saves(List<Ship> value) {
    update(value);
  }

  static void saveShip(Ship ship) {
    //? Save in runtime
    var lCopy = saves.toList(growable: true);
    lCopy.add(ship);
    saves = lCopy;

    //? Save persistent
    update(lCopy);
  }

  static void deleteShipAt(int index) {
    var lCopy = saves.toList(growable: true);
    lCopy.removeAt(index);

    update(lCopy);
  }

  static void update(List<Ship> newList) {
    _notifier.value = newList;
    JsonLoader.writeFile(
      jsonEncode([for (var s in saves) s.toJson()]),
      shipSaveFileName,
      'json',
    );
  }
}
