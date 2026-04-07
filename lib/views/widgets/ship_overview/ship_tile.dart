import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';
import 'package:kaehne_und_kraken/views/pages/ship_details_Page.dart';

class ShipTile extends StatefulWidget {
  final int index;
  const ShipTile({super.key, required this.index});

  @override
  State<ShipTile> createState() => _ShipTileState();
}

class _ShipTileState extends State<ShipTile> {
  Ship get ship => ShipStorage.saves[widget.index];
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ShipDetailsPage(index: widget.index);
            },
          ),
        );
      },
      title: Text(ship.name),
      subtitle: Text(ship.size.name),
      trailing: PopupMenuButton(
        itemBuilder: (context) {
          return <PopupMenuItem>[
            PopupMenuItem(
              onTap: () {},
              child: ListTile(
                leading: Icon(Icons.mode_edit_rounded),
                title: Text('Bearbeiten'),
              ),
            ),
            PopupMenuItem(
              onTap: () {
                ShipStorage.deleteShipAt(widget.index);
              },
              child: ListTile(
                leading: Icon(Icons.delete_outlined),
                title: Text('Löschen'),
              ),
            ),
            PopupMenuItem(child: Text(ship.name)),
          ];
        },
      ),
    );
  }
}
