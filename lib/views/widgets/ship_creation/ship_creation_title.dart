import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/app_data.dart';
import 'package:kaehne_und_kraken/data/classes/ship.dart';
import 'package:kaehne_und_kraken/data/styles/colors.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';
import 'package:kaehne_und_kraken/views/widgets/content/text_sections/text_section_root.dart';
import 'package:kaehne_und_kraken/views/widgets/displays/custom_popup.dart';
import 'package:kaehne_und_kraken/views/widgets/inputs/input_field.dart';
import 'package:kaehne_und_kraken/views/widgets/decoration/statblock_tile.dart';

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
            title: Row(
              children: [
                Text(
                  'Grössenkategorie',
                  style: Theme.of(context).textTheme.titleSmall,
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

            trailing: DropdownButton(
              underline: Container(height: 2, color: titleColor),
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
