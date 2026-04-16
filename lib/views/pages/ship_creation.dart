import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';
import 'package:kaehne_und_kraken/views/widget_tree.dart';
import 'package:kaehne_und_kraken/views/widgets/general/app_bar_widget.dart';
import 'package:kaehne_und_kraken/views/widgets/general/body_widget.dart';
import 'package:kaehne_und_kraken/views/widgets/inputs/input_field.dart';
import 'package:kaehne_und_kraken/views/widgets/ship_creation/ship_creation_defenses.dart';
import 'package:kaehne_und_kraken/views/widgets/ship_creation/ship_creation_title.dart';
import 'package:kaehne_und_kraken/views/widgets/decoration/statblock_tile.dart';

class ShipCreation extends StatefulWidget {
  const ShipCreation({super.key});

  @override
  State<ShipCreation> createState() => _ShipCreationState();
}

class _ShipCreationState extends State<ShipCreation> {
  final ValueNotifier<HullDice?> hullDieTypeNotifier = ValueNotifier(null);
  final ValueNotifier<int?> hulldiceAmtNotifier = ValueNotifier(null);
  final ExpansibleController exController = ExpansibleController();
  bool useDefaultCrew = true;
  bool alert = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        header: 'Schiff erstellen',
        leading: IconButton(
          onPressed: () async {
            bool? leave = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Zurück zur Übersicht?'),
                  content: Text('Dein Schiff wird verworfen!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // selectedPageNotifier.value = 0;
                        Navigator.pop(context, true);
                      },
                      child: Text('verwerfen und zurück'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Text('Weiter bearbeiten'),
                    ),
                  ],
                );
              },
            );
            if (leave == true) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WidgetTree()),
              );
            }
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: BodyWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ShipCreationTitle(alert: alert),
              ShipCreationDefenses(
                alert: alert,
                hulldiceAmtNotifier: hulldiceAmtNotifier,
                hulldiceTypeNotifier: hullDieTypeNotifier,
              ),
              StatblockTile(
                children: [
                  ExpansionTile(
                    shape: Border(bottom: BorderSide.none),
                    showTrailingIcon: false,
                    controller: exController,
                    title: Row(
                      children: [
                        Text('Standart Crew'),
                        Checkbox(
                          value: useDefaultCrew,
                          onChanged: (value) {
                            setState(() {
                              useDefaultCrew = value ?? false;
                              useDefaultCrew
                                  ? exController.collapse()
                                  : exController.expand();
                            });
                          },
                        ),
                      ],
                    ),
                    children: [
                      InputField(
                        label: 'CrewAktionen',
                        onEditingComplete: (value) {},
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'submit',
        onPressed: () {
          onSubmit();
        },
        child: Icon(Icons.save),
      ),
    );
  }

  void onSubmit() {
    if (shipCreationNameNotifier.value == null ||
        shipCreationSizeNotifier.value == null ||
        shipCreationHullSPNotifier.value == null ||
        shipCreationSailSPNotifier.value == null ||
        shipCreationRudderSPNotifier.value == null ||
        hullDieTypeNotifier.value == null ||
        hulldiceAmtNotifier.value == null) {
      setState(() {
        alert = true;
      });
      return;
    } else {
      Ship.create(
        name: shipCreationNameNotifier.value!,
        size: shipCreationSizeNotifier.value!,
        hullSP: shipCreationHullSPNotifier.value!,
        rudderSP: shipCreationRudderSPNotifier.value!,
        sailSP: shipCreationSailSPNotifier.value!,
        hullDiceType: hullDieTypeNotifier.value!,
        hullDiceAmt: hulldiceAmtNotifier.value!,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WidgetTree();
          },
        ),
      );
    }
  }
}
