import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:kaehne_und_kraken/views/widgets/general/app_bar_widget.dart';
import 'package:kaehne_und_kraken/views/widgets/general/body_widget.dart';
import 'package:kaehne_und_kraken/views/widgets/ship_creation/ship_creation_defenses.dart';
import 'package:kaehne_und_kraken/views/widgets/ship_creation/ship_creation_title.dart';

class ShipCreation extends StatelessWidget {
  ShipCreation({super.key});
  final ValueNotifier<String?> nameNotifier = ValueNotifier(null);
  final ValueNotifier<ShipSize?> sizeNotifier = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(header: 'Schiff erstellen'),
      body: BodyWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ShipCreationTitle(
                nameNotifier: nameNotifier,
                sizeNotifier: sizeNotifier,
              ),
              ShipCreationDefenses(),
            ],
          ),
        ),
      ),
    );
  }

  void onSubmit() {}
}
