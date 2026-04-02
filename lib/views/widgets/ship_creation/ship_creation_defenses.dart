import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';
import 'package:kaehne_und_kraken/views/widgets/input_field.dart';
import 'package:kaehne_und_kraken/views/widgets/ship_creation/ship_creation_structure_points.dart';
import 'package:kaehne_und_kraken/views/widgets/statblock/statblock_tile.dart';

class ShipCreationDefenses extends StatefulWidget {
  final bool alert;
  const ShipCreationDefenses({super.key, this.alert = false});

  @override
  State<ShipCreationDefenses> createState() => _ShipCreationDefensesState();
}

class _ShipCreationDefensesState extends State<ShipCreationDefenses> {
  int? numHullDice;
  bool? useD6;

  @override
  Widget build(BuildContext context) {
    return StatblockTile(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //===HÜLLENWÜRFEL===//
            SizedBox(
              width: 200.0,
              child: InputField(
                label: 'Hüllenwürfel',
                type: TextInputType.numberWithOptions(),
                onEditingComplete: (value) {},
              ),
            ),
            DropdownButton(
              style: Theme.of(context).textTheme.bodyLarge,
              value: useD6,
              dropdownColor: Colors.white,
              items: [
                DropdownMenuItem(value: false, child: Text('d4')),
                DropdownMenuItem(value: true, child: Text('d6')),
              ],
              onChanged: (value) {
                setState(() {
                  useD6 = value!;
                });
              },
            ),
          ],
        ),
        ShipCreationStructurePoints(),
      ],
    );
  }
}
