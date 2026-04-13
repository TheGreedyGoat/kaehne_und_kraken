import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:kaehne_und_kraken/utility/file_loader.dart';

//TODO: Migrate all file and save related functionality
class AppData {
  static final ValueNotifier<List<Ship>> _savedShipsNotifier = ValueNotifier(
    [],
  );
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
    late List<Ship> ships = [];

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

  //  ######
  //  #     # #    # #      ######  ####
  //  #     # #    # #      #      #
  //  ######  #    # #      #####   ####
  //  #   #   #    # #      #           #
  //  #    #  #    # #      #      #    #
  //  #     #  ####  ###### ######  ####
  static Future<void> _loadRules() async {}
}
