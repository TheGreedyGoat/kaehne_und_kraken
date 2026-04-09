import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:kaehne_und_kraken/data/colors.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';
import 'package:kaehne_und_kraken/views/widgets/decoration/statblockBorder.dart';
import 'package:kaehne_und_kraken/views/widgets/displays/percentage_bar.dart';
import 'package:kaehne_und_kraken/views/widgets/general/app_bar_widget.dart';
import 'package:kaehne_und_kraken/views/widgets/general/body_widget.dart';
import 'package:kaehne_und_kraken/views/widgets/inputs/number_input.dart';

class ShipDetailsPage extends StatefulWidget {
  final int shipIndex;

  const ShipDetailsPage({super.key, required this.shipIndex});
  @override
  State<ShipDetailsPage> createState() => _ShipDetailsPageState();
}

class _ShipDetailsPageState extends State<ShipDetailsPage> {
  late Ship ship;
  @override
  void initState() {
    assert(
      widget.shipIndex >= 0 && widget.shipIndex < ShipStorage.saves.length,
      'Invalid Index ${widget.shipIndex} in ShipDetailsPage',
    );
    ship = ShipStorage.saves[widget.shipIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(header: ship.name),
      body: BodyWidget(
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadiusGeometry.zero,
                    ),
                    child: StatBlockBorder(
                      height: 400,
                      backgroundImagePath:
                          'assets/images/parchment_bg_dark.png',
                      child: NumberInput(title: 'Rumpf'),
                    ),
                  ),
                );
              },
              child: SizedBox(
                width: double.infinity,
                height: 75,
                child: Container(
                  decoration: BoxDecoration(color: noteColor),
                  child: IgnorePointer(
                    child: PercentageBar(
                      min: 0.0,
                      max: ship.hullSP.currentMax.toDouble(),
                      initValue: ship.hullSP.current.toDouble(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
