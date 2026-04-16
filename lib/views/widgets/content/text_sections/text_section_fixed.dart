import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/utility/text_section.dart';
import 'package:kaehne_und_kraken/views/widgets/content/text_sections/text_section_root.dart';
import 'package:kaehne_und_kraken/views/widgets/decoration/statblock_tile.dart';
import 'package:kaehne_und_kraken/views/widgets/displays/formatted_text.dart';

class TextSectionFixed extends StatelessWidget {
  final TextSection section;
  const TextSectionFixed({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatblockTile(
          children: [
            TextFormatting.text(
              section.heading.text,
              Formats.titleMedium,
              context,
            ),
            for (var content in section.content)
              TextSectionWidget.displayBlock(content, context),
            for (var subSection in section.subsections)
              TextSectionFixed(section: subSection),
          ],
        ),
      ],
    );
  }
}
