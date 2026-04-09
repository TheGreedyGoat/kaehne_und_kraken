import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';
import 'package:kaehne_und_kraken/views/widgets/decoration/statblockBorder.dart';
import 'package:kaehne_und_kraken/views/widgets/displays/formatted_text.dart';
import 'package:kaehne_und_kraken/views/widgets/general/app_bar_widget.dart';
import 'package:kaehne_und_kraken/views/widgets/general/body_widget.dart';
import 'package:kaehne_und_kraken/views/widgets/inputs/number_input.dart';
import 'package:kaehne_und_kraken/views/widgets/statblock/statblock_tile.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            StatblockTile(
              children: [
                FormattedText('Strukturpunkte:', Formats.titleLarge),
                SizedBox(height: 5.0),
                _displaySP(ship.hullSP, 'Rumpf'),
                SizedBox(height: 5.0),
                _displaySP(ship.sailSP, 'Segel'),
                SizedBox(height: 5.0),
                _displaySP(ship.rudderSP, 'Ruder'),
                SizedBox(height: 5.0),
              ],
            ),

            StatblockTile(
              children: [
                FormattedText(
                  'Agilität: ${ship.agilityScore.toString()}',
                  Formats.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _displaySP(SPPool pool, String name) {
    return GestureDetector(
      onTap: () async {
        int? value = await showDialog<int>(
          context: context,
          builder: (context) => inputDialog(pool, name),
        );
        if (value != null) {
          setState(() {
            value > 0 ? pool.repairAmount(value) : pool.takeDamage(-value);
          });
        }
      },
      child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(border: Border.all()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FormattedText('$name:', Formats.titleMedium),
                FormattedText(
                  " ${pool.current} / ${pool.currentMax} / ${pool.totalMax}",
                  Formats.titleSmall,
                ),
              ],
            ),
            SizedBox(width: 300, height: 10, child: pool.barWidget(300)),
          ],
        ),
      ),
    );
  }

  Dialog inputDialog(SPPool pool, String name) {
    return Dialog(
      shape: BeveledRectangleBorder(borderRadius: BorderRadiusGeometry.zero),
      child: StatBlockBorder(
        height: 400,
        backgroundImagePath: 'assets/images/parchment_bg_dark.png',
        child: NumberInput(title: name),
      ),
    );
  }
}
