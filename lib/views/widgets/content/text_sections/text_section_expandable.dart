import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/utility/text_section.dart';
import 'package:kaehne_und_kraken/views/widgets/content/text_sections/text_section_root.dart';

class TextSectionExpandable extends StatefulWidget {
  final TextSection section;

  const TextSectionExpandable({super.key, required this.section});

  @override
  State<TextSectionExpandable> createState() => _TextSectionExpandableState();
}

class _TextSectionExpandableState extends State<TextSectionExpandable> {
  static const double insetFactor = 5.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: insetFactor * widget.section.level),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            shape: Border(),
            title: TextSectionWidget.heading(
              heading: widget.section.heading,
              context: context,
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
      ),
    );
  }
}
