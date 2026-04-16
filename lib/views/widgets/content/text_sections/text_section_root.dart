import 'package:flutter/material.dart';
import 'package:flutter_md/flutter_md.dart';
import 'package:kaehne_und_kraken/utility/text_section.dart';
import 'package:kaehne_und_kraken/views/widgets/content/text_sections/text_section_expandable.dart';
import 'package:kaehne_und_kraken/views/widgets/content/text_sections/text_section_fixed.dart';
import 'package:kaehne_und_kraken/views/widgets/displays/formatted_text.dart';

enum TextSectionDisplay { fixed, expandable }

class TextSectionWidget extends StatelessWidget {
  final TextSection section;
  final TextSectionDisplay display;
  const TextSectionWidget({
    super.key,
    required this.section,
    this.display = TextSectionDisplay.fixed,
  });

  @override
  Widget build(BuildContext context) {
    switch (display) {
      case TextSectionDisplay.fixed:
        return TextSectionFixed(section: section);
      case TextSectionDisplay.expandable:
        return TextSectionExpandable(section: section);
    }
  }

  static Widget displayBlock(MD$Block block, BuildContext context) {
    switch (block.type) {
      case 'table':
        return fromTableBlock(block as MD$Table, context);
      default:
        return TextFormatting.text(block.text, Formats.bodyMedium, context);
    }
  }
  //  #######
  //     #      ##   #####  #      ######
  //     #     #  #  #    # #      #
  //     #    #    # #####  #      #####
  //     #    ###### #    # #      #
  //     #    #    # #    # #      #
  //     #    #    # #####  ###### ######

  static Widget fromTableBlock(MD$Table table, context) {
    return Table(
      defaultColumnWidth: IntrinsicColumnWidth(),
      children: [
        //====HEADER====//
        TableRow(
          children: [
            for (var cell in table.header.cells)
              for (var span in cell)
                tableCell(
                  child: TextFormatting.text(
                    span.text,
                    Formats.bodyMedium,
                    context,
                    700,
                  ),
                ),
          ],
        ),

        for (int i = 0; i < table.rows.length; i++)
          TableRow(
            decoration: BoxDecoration(
              color: i % 2 == 0 ? Color(0xffe0e5c1) : null,
            ),
            children: [
              for (var cell in table.rows[i].cells)
                for (var span in cell)
                  tableCell(
                    child: TextFormatting.text(
                      span.text,
                      Formats.bodySmall,
                      context,
                    ),
                  ),
            ],
          ),
      ],
    );
  }

  static Widget tableCell({required Widget child, double leftPadding = 5.0}) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: child,
    );
  }
}
