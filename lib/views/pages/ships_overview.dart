import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/colors.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';
import 'package:kaehne_und_kraken/views/pages/ship_creation.dart';
import 'package:kaehne_und_kraken/views/widgets/ship_overview/ship_tile.dart';

class ShipsOverview extends StatefulWidget {
  const ShipsOverview({super.key});

  @override
  State<ShipsOverview> createState() => _ShipsOverviewState();
}

class _ShipsOverviewState extends State<ShipsOverview> {
  List<Widget> _listChildren() {
    return ShipStorage.saves.isNotEmpty
        ? [
            for (int i = 0; i < ShipStorage.saves.length; i++)
              Column(
                children: [
                  ShipTile(index: i),
                  Container(height: 2, color: titleColor),
                ],
              ),
          ]
        : [
            ListTile(
              title: Text('Du hast noch keine Schiffe gespeichert.'),
              trailing: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ShipCreation();
                      },
                    ),
                  );
                },
                icon: Icon(Icons.add),
              ),
            ),
          ];
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ShipStorage.notifier,
      builder: (context, foundShips, child) {
        return ListView(children: _listChildren());
      },
    );
  }
}
