import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_md/flutter_md.dart';
import 'package:kaehne_und_kraken/utility/text_section.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:dropbox_client/dropbox_client.dart';
import 'package:http/http.dart' as http;

class AppData {
  //   #####
  //  #     # ###### #    # ###### #####    ##   #
  //  #       #      ##   # #      #    #  #  #  #
  //  #  #### #####  # #  # #####  #    # #    # #
  //  #     # #      #  # # #      #####  ###### #
  //  #     # #      #   ## #      #   #  #    # #
  //   #####  ###### #    # ###### #    # #    # ######
  static const String _dropBoxAccessToken =
      'sl.u.AGaRwJNuNyW99xaP-Ei__5aV8vtDNfpEd6P83SNCe50HoIwufjmUalV0tS_MLchshQrWX4im_Y1c09wy51CUt9ftA08vBuYlgxwmQea-nlpNbKwTUB4TwCxs0xmccUcMzP3R3i6Mdo4pEoUPta7_PgcWAWi4HCcFtLc8k8mVUoBrFNzcnBvUwsUWAfIpzFHAqmBCU34G283RRFC6Zrf0NCZP4q37ogXRHV2pwZ3epWb-gqukFFCmocxmgUm_fIClK-RIorF9_13s2mHJGNDk9IroCj0-SzClBJ8f9I2ay9aLXiSwkbmPcACMsfMcIXG-3pQEqxNDFjMAVywf2Oef-TjAxqCYyY7JlpVEisX6mwhoP6UFJPvSeEBtC8gR2JFVVW5FQPbPyF97EMzFtvg7rzWvR1VyhrhvXzkthZuKnim-FPAeHrfhUObVeb4NIgyxn3TT3Ag54UJTnOZx0bYT2DO0xfKBgm44YdN60Oy-LKRy2BxFqMuH14G22GnbFIj8V9wwA9ysk4x9-z2u6vulxWUy78aaC9H22cXRrvAs-kwDiwosFTcjJNoeO_-d_ZTdUBvpeHMzDoAI__AF-twmKKVbVCTQTOkkrlfDFYBpIgln6tcl321Ny3R3BCUL7pAeCHwEenvxeCCGdNJHRU_he1ZAOfUlqm7ZOMQGeuGuJAXpoM1UG1eNv8eWJAlJ35rvdD_wNgambW5gPfUBsPhs72yuNQwJdx9VbSSffso3-w-sCQIFMxDdTvgKrDF2XAhwxxUXQ60jt9yrfqvMvCb9RNrXgYcZKht0wEDlh1WaG3qq-5nNZPYgAhNYgGZD8lfbB1EWFuxVX2ABuVYrYLwX_NNL3H--kQzl3WsRrPfE9KTAN77pzGB_ZJv-Q4z7I10bhGa2bfoVzSfdV9zIgpdmdrGLDVWNfcIcg8SemTmglQKcSlqpp4AzZfjezZJxeRNt2XoqU5ok_4eNmDvx05Hf-QM9xeTsA1NXk6QUgq4X9v2p4yMi-F8GnWMLFDAPSu6Gg4b1aD0WiVubwy1lXwoSgDpeDBnY1lQz3ad0e3FCTBDva5sGF74tkOHNHteFrwcbxTRefq4L3L_FlU98pp-vRpVf0J1mUCE-g-7DIVT6SxM21PlmSpIpHaZ--YhHSEDkv-4Reon5yOMmJpdyHa5dppRJcLDnm9uHj0zRoZjiKYslkgwGFx93gEMatT4F10G6T_YdzTYWJKxPuqZXp6QGLBL4QAtMbohoWvCBlVu4AzmhsnkIUjHJfTBmVkSKvBBHn7Y5WMq3YiL0Uz_7odHmR4teheo6brcqN6nmvYAEGvSDiQ';
  static Future<void> load() async {
    await _loadShips();
    await _loadRules();
  }

  static Future<String?> _fetchFromDropBox(String dropBoxFilePath) async {
    try {
      final response = await http.post(
        Uri.parse('https://content.dropboxapi.com/2/files/download'),
        headers: {
          'Authorization': 'Bearer $_dropBoxAccessToken',
          'Dropbox-API-Arg': jsonEncode({'path': dropBoxFilePath}),
        },
      );

      if (response.statusCode == 200) {
        final fileContent = utf8.decode(response.bodyBytes);
        print('DropBox download successful: $dropBoxFilePath');
        return fileContent;
      } else {
        print('DropBox download failed: ${response.statusCode}');
        print('Request path: $dropBoxFilePath');
        print('Response body: ${response.body}');
        throw Exception(
          'Fehler beim Laden der Datei von DropBox: ${response.statusCode}',
        );
      }
    } on Exception catch (e) {
      print('Fehler: $e');

      return null;
    }
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

  static void _refreshSavedShips() {
    _savedShipsNotifier.value = _savedShipsNotifier.value.toList(
      growable: true,
    );
    updateShipFile();
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
  static const String rulesDBPath = '/rules.md';
  static const String localRulesName = 'rules';
  static const markDownExt = 'md';
  static Future<void> _loadRules() async {
    var loadedData = await _fetchFromDropBox(rulesDBPath);
    if (loadedData != null) {
      await _writeLocalFile(loadedData, localRulesName, markDownExt);
    } else {
      loadedData = await _readFile(localRulesName, markDownExt);
    }

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
    ruleSections = TextSection.fromMDBlocks(md.blocks);
  }

  static TextSection tryFindSection(String title, List<TextSection> tree) {
    for (var section in tree) {
      if (section.heading.text == title) {
        return section;
      }
      var sub = tryFindSection(title, section.subsections);
      if (sub != TextSection.notFound) {
        return sub;
      }
    }
    return TextSection.notFound;
  }
}
