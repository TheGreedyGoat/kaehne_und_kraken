import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:kaehne_und_kraken/utility/file_loader.dart';

class AppData {
  static final ValueNotifier<List<Ship>> _savedShipsNotifier = ValueNotifier(
    List.empty(growable: true),
  );

  static List get saves => _savedShipsNotifier.value;
  static ValueNotifier get notifier => _savedShipsNotifier;
  static Map<String, Map<String, String>> gameRules = {};

  //   #####
  //  #     # #    # # #####   ####
  //  #       #    # # #    # #
  //   #####  ###### # #    #  ####
  //        # #    # # #####       #
  //  #     # #    # # #      #    #
  //   #####  #    # # #       ####

  static Future<void> load() async {
    await _loadShips();
    await _loadRules();
  }

  static Future<void> _loadShips() async {
    String mapListString = await FileLoader.readFile(shipSaveFileName, 'json');
    late List<Ship> ships = List.empty(growable: true);

    try {
      var maps = jsonDecode(mapListString);
      ships = List.of([
        for (var map in maps) Ship.fromJson(map),
      ], growable: true);
    } on Exception catch (e) {
      e.toString();
    }
    if (ships.isEmpty) {
      ships.add(Ship.jackdaw());
      ships.add(Ship.queenAnne());
    }
    _savedShipsNotifier.value = ships;
  }

  static void addNewShip(Ship ship) {
    saves.add(ship);
    updateShipFile();
    refreshSavedShips();
  }

  static void deleteShipAt(int index) {
    saves.removeAt(index);
    refreshSavedShips();
  }

  static void refreshSavedShips() {
    _savedShipsNotifier.value = _savedShipsNotifier.value.toList(
      growable: true,
    );
    updateShipFile();
  }

  static void updateShipFile() {
    FileLoader.writeFile(
      jsonEncode([for (var s in saves) s.toJson()]),
      shipSaveFileName,
      'json',
    );
  }

  //  ######
  //  #     # #    # #      ######  ####
  //  #     # #    # #      #      #
  //  ######  #    # #      #####   ####
  //  #   #   #    # #      #           #
  //  #    #  #    # #      #      #    #
  //  #     #  ####  ###### ######  ####
  static Future<void> _loadRules() async {
    //TODO
  }
}
