import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_md/flutter_md.dart';
import 'package:kaehne_und_kraken/utility/markdown_to_widgets.dart';
import 'package:kaehne_und_kraken/utility/text_section.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';

class AppData {
  static Future<void> load() async {
    await _loadShips();
    await _loadRules();
  }

  //   #####
  //  #     # #    # # #####   ####
  //  #       #    # # #    # #
  //   #####  ###### # #    #  ####
  //        # #    # # #####       #
  //  #     # #    # # #      #    #
  //   #####  #    # # #       ####

  static final ValueNotifier<List<Ship>> _savedShipsNotifier = ValueNotifier(
    List.empty(growable: true),
  );

  static List get saves => _savedShipsNotifier.value;
  static ValueNotifier get notifier => _savedShipsNotifier;
  static const shipSaveFileName = 'ships';

  //====ACCESS====//
  static void addNewShip(Ship ship) {
    saves.add(ship);
    updateShipFile();
    _refreshSavedShips();
  }

  static void deleteShipAt(int index) {
    saves.removeAt(index);
    _refreshSavedShips();
  }

  static void updateShipFile() {
    _writeLocalFile(
      jsonEncode([for (var s in saves) s.toJson()]),
      shipSaveFileName,
      'json',
    );
  }
  //====INTERNAL====//

  static Future<void> _loadShips() async {
    String mapListString = await _readFile(
      shipSaveFileName,
      'json',
    );
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

  static Future<String> _readFile(
    String fileName,
    String extension,
  ) async {
    final file = await _getLocalFile(fileName, extension);
    if (!await file.exists()) {
      await file.create();
      file.writeAsString('[]');
    }
    return file.readAsString();
  }

  static Future<File> _getLocalFile(
    String fileName,
    String extension,
  ) async {
    final path = await _localPath;
    return File('$path/$fileName.$extension');
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static void _refreshSavedShips() {
    _savedShipsNotifier.value = _savedShipsNotifier.value.toList(
      growable: true,
    );
    updateShipFile();
  }

  static Future<File> _writeLocalFile(
    String content,
    String fileName,
    String extension,
  ) async {
    final file = await _getLocalFile(fileName, extension);

    return file.writeAsString(content);
  }

  //  ######
  //  #     # #    # #      ######  ####
  //  #     # #    # #      #      #
  //  ######  #    # #      #####   ####
  //  #   #   #    # #      #           #
  //  #    #  #    # #      #      #    #
  //  #     #  ####  ###### ######  ####

  static late List<TextSection> ruleSections;
  static const String rulesPath = 'assets/markdown/test.md';
  static Future<void> _loadRules() async {
    var loadedData = await loadAssetFile(path: rulesPath);
    _onRulesLoaded(loadedData);
  }

  static Future<String> loadAssetFile({
    required String path,
    Function(String)? callback,
  }) async {
    final loadedData = await rootBundle.loadString(path);
    callback?.call(loadedData.toString());
    return loadedData;
  }

  static void _onRulesLoaded(String data) async {
    Markdown md = Markdown.fromString(data);
    print(md.blocks.length);
    var l = TextSection.fromMDBlocks(md.blocks);
    for (var sec in l) {
      print(sec);
    }
  }

  static bool isHeading(MD$Block block, int level) {
    return (block is MD$Heading) && block.level == level;
  }
}
