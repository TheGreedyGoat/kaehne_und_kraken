import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';

final List<Ship> savedShips = List.of([
  Ship(
    name: 'Jackdaw',
    size: ShipSize.medium,
    hullSP: 100,
    rudderSP: 50,
    sailSP: 35,
  ),
  Ship(
    name: "Queen Ann's Revenge",
    size: ShipSize.huge,
    hullSP: 350,
    rudderSP: 125,
    sailSP: 120,
  ),
], growable: true);

class ShipsOverview extends StatefulWidget {
  const ShipsOverview({super.key});

  @override
  State<ShipsOverview> createState() => _ShipsOverviewState();
}

class _ShipsOverviewState extends State<ShipsOverview> {
  @override
  Widget build(BuildContext context) {
    return savedShips.length > 0
        ? ListView(
            children: [
              for (var s in savedShips)
                ListTile(
                  title: Text(s.name),
                  subtitle: Text(s.size.name),
                  trailing: Text('SP: ${s.hullSP.totalMax}'),
                ),
            ],
          )
        : Text('Noch kein Schiff erstellt');
  }
}
