import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/utility/text_section.dart';
import 'package:kaehne_und_kraken/views/widgets/content/text_sections/text_section_root.dart';
import 'package:kaehne_und_kraken/views/widgets/decoration/statblock_tile.dart';
import 'package:kaehne_und_kraken/views/widgets/displays/formatted_text.dart';

class TextSectionExpandable extends StatefulWidget {
  final TextSection section;

  const TextSectionExpandable({super.key, required this.section});

  @override
  State<TextSectionExpandable> createState() => _TextSectionExpandableState();
}

//   #####
//  #     # #####   ##   ##### ######
//  #         #    #  #    #   #
//   #####    #   #    #   #   #####
//        #   #   ######   #   #
//  #     #   #   #    #   #   #
//   #####    #   #    #   #   ######

class _TextSectionExpandableState extends State<TextSectionExpandable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          shape: Border(),
          title: StatblockTile(
            children: [
              TextFormatting.text(
                widget.section.heading.text,
                Formats.titleMedium,
                context,
              ),
            ],
          ),
          children: [
            //===Direkter Content===//
            for (var content in widget.section.content)
              TextSectionWidget.displayBlock(content, context),
            //===Subsektionen===//
            for (var subSection in widget.section.subsections)
              TextSectionExpandable(section: subSection),
          ],
        ),
      ],
    );
  }
}
