import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:kaehne_und_kraken/data/colors.dart';
import 'package:kaehne_und_kraken/data/saves/json_loader.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';
import 'package:kaehne_und_kraken/views/widget_tree.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        dialogTheme: DialogThemeData(backgroundColor: noteColor),
        inputDecorationTheme: InputDecorationTheme(
          border: UnderlineInputBorder(),
        ),
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: const Color.fromARGB(188, 122, 69, 48),
          onPrimary: Colors.white,
          secondary: const Color.fromARGB(188, 122, 69, 48),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.red,
          surface: noteColor,
          onSurface: Colors.black,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Mr Eaves',
            fontSize: 30.0,
            fontWeight: FontWeight(700),
            color: titleColor,
          ),
          titleMedium: TextStyle(
            fontFamily: 'Mr Eaves',
            fontSize: 20.0,
            fontWeight: FontWeight(700),
          ),
          titleSmall: TextStyle(
            fontFamily: 'Scaly Sans',
            color: titleColor,
            fontSize: 15,
            fontWeight: FontWeight(700),
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Scaly Sans',
            fontWeight: FontWeight(700),
          ),
          bodyMedium: TextStyle(fontFamily: 'Scaly Sans'),
          bodySmall: TextStyle(fontFamily: 'Scaly Sans'),
        ),
      ),
      home: WidgetTree(),
    ),
  );

  preload();
}

Future<void> preload() async {
  String mapListString = await JsonLoader.readFile(shipSaveFileName, 'json');
  var maps = jsonDecode(mapListString);
  late List<Ship> ships;
  ships = List.of([for (var map in maps) Ship.fromJson(map)], growable: true);
  if (ships.isEmpty) {
    ships.add(
      Ship(
        name: 'Jackdaw',
        size: ShipSize.medium,
        hullSP: 100,
        rudderSP: 30,
        sailSP: 30,
      ),
    );
    ships.add(
      Ship(
        name: "Queen Anne's Revenge",
        size: ShipSize.huge,
        hullSP: 300,
        rudderSP: 100,
        sailSP: 100,
      ),
    );
  }
  ShipStorage.saves = ships;
}
