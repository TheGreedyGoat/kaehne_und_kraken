import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/utility/text_section.dart';
import 'package:kaehne_und_kraken/views/widgets/content/text_sections/text_section_root.dart';
import 'package:kaehne_und_kraken/views/widgets/decoration/statblock_tile.dart';

class TextSectionFixed extends StatelessWidget {
  final TextSection section;
  const TextSectionFixed({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatblockTile(
          children: [
            TextSectionWidget.heading(
              heading: section.heading,
              context: context,
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
