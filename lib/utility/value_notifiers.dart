import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';

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
