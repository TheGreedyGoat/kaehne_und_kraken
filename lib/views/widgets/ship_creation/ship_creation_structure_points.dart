import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';
import 'package:kaehne_und_kraken/views/widgets/input_field.dart';

class ShipCreationStructurePoints extends StatefulWidget {
  const ShipCreationStructurePoints({super.key});

  @override
  State<ShipCreationStructurePoints> createState() =>
      _ShipCreationStructurePointsState();
}

class _ShipCreationStructurePointsState
    extends State<ShipCreationStructurePoints> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Strukturpunkte',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: 50,
              child: InputField(
                label: 'RUMPF',
                isVertical: true,
                type: TextInputType.numberWithOptions(),
                onEditingComplete: (value) {
                  setState(() {
                    shipCreationHullSPNotifier.value = int.tryParse(value);
                  });
                },
              ),
            ),
            SizedBox(
              width: 50,
              child: InputField(
                label: 'SEGEL',
                type: TextInputType.numberWithOptions(),
                isVertical: true,
                onEditingComplete: (value) {
                  setState(() {
                    shipCreationSailSPNotifier.value = int.tryParse(value);
                  });
                },
              ),
            ),
            SizedBox(
              width: 50,
              child: InputField(
                label: 'RUDER',
                type: TextInputType.numberWithOptions(),
                isVertical: true,
                onEditingComplete: (value) {
                  setState(() {
                    shipCreationRudderSPNotifier.value = int.tryParse(value);
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
