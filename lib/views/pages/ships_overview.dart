import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';
import 'package:kaehne_und_kraken/views/widgets/ship_overview/ship_tile.dart';

class ShipsOverview extends StatefulWidget {
  const ShipsOverview({super.key});

  @override
  State<ShipsOverview> createState() => _ShipsOverviewState();
}

class _ShipsOverviewState extends State<ShipsOverview> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ShipStorage.notifier,
      builder: (context, foundShips, child) {
        return ListView(
          children: [
            for (int i = 0; i < ShipStorage.saves.length; i++)
              ShipTile(index: i),
          ],
        );
      },
    );
  }
}
