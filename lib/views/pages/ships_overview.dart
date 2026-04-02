import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';
import 'package:kaehne_und_kraken/views/pages/ship_details_Page.dart';

class ShipsOverview extends StatefulWidget {
  const ShipsOverview({super.key});

  @override
  State<ShipsOverview> createState() => _ShipsOverviewState();
}

class _ShipsOverviewState extends State<ShipsOverview> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: shipStorageNotifier,
      builder: (context, foundShips, child) {
        return ListView(
          children: [
            for (var ship in foundShips)
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ShipDetailsPage(ship: ship);
                      },
                    ),
                  );
                },
                title: Text(ship.name),
                subtitle: Text(ship.size.name),
                trailing: Text('SP: ${ship.hullSP.totalMax}'),
              ),
          ],
        );
      },
    );
  }
}
