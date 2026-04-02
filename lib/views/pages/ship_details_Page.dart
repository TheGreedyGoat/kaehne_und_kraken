import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:kaehne_und_kraken/views/widgets/general/app_bar_widget.dart';
import 'package:kaehne_und_kraken/views/widgets/general/body_widget.dart';

class ShipDetailsPage extends StatefulWidget {
  final Ship ship;
  const ShipDetailsPage({super.key, required this.ship});

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
