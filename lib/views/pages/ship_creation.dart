import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';
import 'package:kaehne_und_kraken/views/pages/ships_overview.dart';
import 'package:kaehne_und_kraken/views/widget_tree.dart';
import 'package:kaehne_und_kraken/views/widgets/general/app_bar_widget.dart';
import 'package:kaehne_und_kraken/views/widgets/general/body_widget.dart';
import 'package:kaehne_und_kraken/views/widgets/ship_creation/ship_creation_defenses.dart';
import 'package:kaehne_und_kraken/views/widgets/ship_creation/ship_creation_title.dart';

class ShipCreation extends StatefulWidget {
  const ShipCreation({super.key});

  @override
  State<ShipCreation> createState() => _ShipCreationState();
}

class _ShipCreationState extends State<ShipCreation> {
  bool alert = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        header: 'Schiff erstellen',
        actions: [
          IconButton(
            onPressed: () {
              onSubmit();
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: BodyWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ShipCreationTitle(alert: alert),
              ShipCreationDefenses(alert: alert),
            ],
          ),
        ),
      ),
    );
  }

  void onSubmit() {
    if (shipCreationNameNotifier.value == null ||
        shipCreationSizeNotifier.value == null ||
        shipCreationHullSPNotifier.value == null ||
        shipCreationSailSPNotifier.value == null ||
        shipCreationRudderSPNotifier.value == null) {
      setState(() {
        alert = true;
      });
      return;
    } else {
      savedShips.add(
        Ship(
          name: shipCreationNameNotifier.value!,
          size: shipCreationSizeNotifier.value!,
          hullSP: shipCreationHullSPNotifier.value!,
          rudderSP: shipCreationRudderSPNotifier.value!,
          sailSP: shipCreationSailSPNotifier.value!,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WidgetTree();
          },
        ),
      );
    }
  }
}
