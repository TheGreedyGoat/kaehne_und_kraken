import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/app_data.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:kaehne_und_kraken/views/widgets/content/text_sections/text_section_root.dart';
import 'package:kaehne_und_kraken/views/widgets/displays/custom_popup.dart';
import 'package:kaehne_und_kraken/views/widgets/general/dropdown.dart';
import 'package:kaehne_und_kraken/views/widgets/inputs/input_field.dart';
import 'package:kaehne_und_kraken/views/widgets/ship_creation/ship_creation_structure_points.dart';
import 'package:kaehne_und_kraken/views/widgets/decoration/statblock_tile.dart';

class ShipCreationDefenses extends StatefulWidget {
  final bool alert;
  final ValueNotifier<int?> hulldiceAmtNotifier;
  final ValueNotifier<HullDice?> hulldiceTypeNotifier;
  const ShipCreationDefenses({
    super.key,
    this.alert = false,
    required this.hulldiceAmtNotifier,
    required this.hulldiceTypeNotifier,
  });

  @override
  State<ShipCreationDefenses> createState() => _ShipCreationDefensesState();
}

class _ShipCreationDefensesState extends State<ShipCreationDefenses> {
  int? numHullDice;
  bool? useD6;
  late ValueNotifier<HullDice?> hullDiceTypeNotifier;
  late ValueNotifier<int?> hulldiceAmtNotifier;
  @override
  void initState() {
    hulldiceAmtNotifier = widget.hulldiceAmtNotifier;
    hullDiceTypeNotifier = widget.hulldiceTypeNotifier;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatblockTile(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //===HÜLLENWÜRFEL ANZAHL===//
            SizedBox(
              width: 200.0,
              child: InputField(
                label: 'Hüllenwürfel',
                type: TextInputType.numberWithOptions(),
                onEditingComplete: (value) {
                  hulldiceAmtNotifier.value = int.tryParse(value);
                },
              ),
            ),
            //====HÜLLENWÜRFEL TYP====//
            MyDropDown(
              items: [
                for (var die in HullDice.values)
                  DropdownMenuItem(value: die, child: Text(die.name)),
              ],
              listener: hullDiceTypeNotifier,
            ),
            CustomPopup(
              popupContent: TextSectionWidget(
                section: AppData.tryFindSection(
                  'Grössenklasse (GK)',
                  AppData.ruleSections,
                ),
              ),
              child: Icon(Icons.help),
            ),
          ],
        ),
        ShipCreationStructurePoints(),
      ],
    );
  }
}
