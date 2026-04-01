import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:kaehne_und_kraken/views/widgets/input_field.dart';
import 'package:kaehne_und_kraken/views/widgets/statblock/statblock_tile.dart';

class ShipCreationTitle extends StatefulWidget {
  final ValueNotifier<String?> nameNotifier;
  final ValueNotifier<ShipSize?> sizeNotifier;
  const ShipCreationTitle({
    super.key,
    required this.nameNotifier,
    required this.sizeNotifier,
  });

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
          onEditingComplete: (value) {},
          inputStyle: Theme.of(context).textTheme.titleLarge,
        ),

        //======SIZE CATEGORY=========//
        SizedBox(
          width: 300.0,
          child: ListTile(
            contentPadding: EdgeInsets.all(0.0),
            style: ListTileStyle.drawer,
            title: Text(
              'Grössenkategorie',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            trailing: DropdownButton(
              padding: EdgeInsets.only(left: 5.0),
              style: Theme.of(context).textTheme.bodyLarge,
              isDense: true,
              value: widget.sizeNotifier.value ?? ShipSize.medium,
              items: [
                for (var size in ShipSize.values)
                  DropdownMenuItem(value: size, child: Text(size.name)),
              ],
              onChanged: (value) {
                setState(() {
                  widget.sizeNotifier.value = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
