import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';
import 'package:kaehne_und_kraken/views/widgets/input_field.dart';
import 'package:kaehne_und_kraken/views/widgets/statblock/statblock_tile.dart';

class ShipCreationTitle extends StatefulWidget {
  final bool alert;
  const ShipCreationTitle({super.key, this.alert = false});

  @override
  State<ShipCreationTitle> createState() => _ShipCreationTitleState();
}

class _ShipCreationTitleState extends State<ShipCreationTitle> {
  @override
  Widget build(BuildContext context) {
    return StatblockTile(
      children: [
        //======SHIP NAME=========//
        InputField(
          label: 'Name',
          onEditingComplete: (value) {
            print(
              'MNKFGNKLNGLDKFFNKLDFNGERITEOGJERI(%UZT%HTV TZ(%T))DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD',
            );
            shipCreationNameNotifier.value = value;
          },
          inputStyle: Theme.of(context).textTheme.titleLarge,
        ),
        widget.alert && shipCreationNameNotifier.value == null
            ? Text('erforderlich!', style: TextStyle(color: Colors.red))
            : SizedBox.shrink(),
        //======SIZE CATEGORY=========//
        SizedBox(
          width: 300.0,
          child: ListTile(
            contentPadding: EdgeInsets.all(0.0),
            title: Text(
              'Grössenkategorie',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            trailing: DropdownButton(
              padding: EdgeInsets.only(left: 5.0),
              style: Theme.of(context).textTheme.bodyLarge,
              isDense: true,
              value: shipCreationSizeNotifier.value,
              items: [
                for (var size in ShipSize.values)
                  DropdownMenuItem(value: size, child: Text(size.name)),
              ],
              onChanged: (value) {
                setState(() {
                  shipCreationSizeNotifier.value = value;
                });
              },
            ),
          ),
        ),
        widget.alert && shipCreationSizeNotifier.value == null
            ? Text('erforderlich!', style: TextStyle(color: Colors.red))
            : SizedBox.shrink(),
      ],
    );
  }
}
