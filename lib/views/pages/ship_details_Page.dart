import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';
import 'package:kaehne_und_kraken/views/widgets/general/app_bar_widget.dart';
import 'package:kaehne_und_kraken/views/widgets/general/body_widget.dart';

class ShipDetailsPage extends StatefulWidget {
  final int index;
  late Ship ship;
  ShipDetailsPage({super.key, required this.index}) {
    if (ShipStorage.saves.length <= index) {
      throw Exception(
        'Index $index does not exist for shipStorage. length is ${ShipStorage.saves.length}',
      );
    }
    ship = ShipStorage.saves[index];
  }
  @override
  State<ShipDetailsPage> createState() => _ShipDetailsPageState();
}

class _ShipDetailsPageState extends State<ShipDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(header: widget.ship.name),
      body: BodyWidget(child: Center(child: Text(widget.ship.name))),
    );
  }
}
