import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';
import 'package:kaehne_und_kraken/views/widgets/displays/percentage_bar.dart';
import 'package:kaehne_und_kraken/views/widgets/general/app_bar_widget.dart';
import 'package:kaehne_und_kraken/views/widgets/general/body_widget.dart';
import 'package:kaehne_und_kraken/views/widgets/inputs/number_input.dart';

class ShipDetailsPage extends StatefulWidget {
  final int shipIndex;

  const ShipDetailsPage({super.key, required this.shipIndex});
  @override
  State<ShipDetailsPage> createState() => _ShipDetailsPageState();
}

class _ShipDetailsPageState extends State<ShipDetailsPage> {
  late Ship ship;
  @override
  void initState() {
    assert(
      widget.shipIndex >= 0 && widget.shipIndex < ShipStorage.saves.length,
      'Invalid Index ${widget.shipIndex} in ShipDetailsPage',
    );
    ship = ShipStorage.saves[widget.shipIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(header: ship.name),
      body: BodyWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                NumberInput(),
                PercentageBar(min: 0.0, max: 100.0, initValue: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
