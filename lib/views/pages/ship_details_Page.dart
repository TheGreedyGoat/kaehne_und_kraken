import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/app_data.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:kaehne_und_kraken/views/widgets/decoration/statblock_border.dart';
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
      widget.shipIndex >= 0 && widget.shipIndex < AppData.saves.length,
      'Invalid Index ${widget.shipIndex} in ShipDetailsPage',
    );
    ship = AppData.saves[widget.shipIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        header: "${ship.name}\n",
        subHeader: ship.className,
        centerTitle: false,
      ),
      body: BodyWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            StatblockTile(
              children: [
                TextFormatting.text(
                  'Strukturpunkte:',
                  Formats.titleLarge,
                  context,
                ),
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
                TextFormatting.textSpan(<String, Formats>{
                  'Agilität: ': Formats.bodyLarge,
                  ship.agilityScore.toString(): Formats.bodyMedium,
                }, context),
                TextFormatting.textSpan(<String, Formats>{
                  'Beschleunigungsbous: ': Formats.bodyLarge,
                  TextFormatting.signedNumber(ship.accelerationMod):
                      Formats.bodyMedium,
                }, context),
                TextFormatting.textSpan(<String, Formats>{
                  'Wendekreis: ': Formats.bodyLarge,
                  '${ship.hexPerTurn}': Formats.bodyMedium,
                }, context),
              ],
            ),
            StatblockTile(
              children: [
                Center(
                  child: TextFormatting.text(
                    'Crew',
                    Formats.titleMedium,
                    context,
                  ),
                ),
                _displaySP(ship.crewActions, 'Crewaktionen'),
                TextFormatting.textSpan({
                  'Moral: ': Formats.bodyLarge,
                  ship.crewMorale.toString(): Formats.bodyMedium,
                }, context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _displaySP(ValuePool pool, String name) {
    return GestureDetector(
      onTap: () async {
        NumInputAction? value = await showDialog<NumInputAction>(
          context: context,
          builder: (context) => inputDialog(pool, name),
        );
        if (value != null) {
          setState(() {
            value.call();
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
                TextFormatting.text('$name:', Formats.titleMedium, context),
                TextFormatting.text(
                  " ${pool.current} / ${pool.limit} / ${pool.capacity}",
                  Formats.titleSmall,
                  context,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 300, height: 10, child: pool.barWidget(300)),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: PopupMenuButton<Function>(
                    onSelected: (callBack) {
                      setState(() => callBack());
                    },
                    itemBuilder: (context) {
                      return pool.popup;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Dialog inputDialog(ValuePool pool, String name) {
    return Dialog(
      shape: BeveledRectangleBorder(borderRadius: BorderRadiusGeometry.zero),
      child: StatBlockBorder(
        height: 400,
        backgroundImagePath: 'assets/images/parchment_bg_dark.png',
        child: NumberInput(title: name, actions: pool.inputActions(context)),
      ),
    );
  }
}
