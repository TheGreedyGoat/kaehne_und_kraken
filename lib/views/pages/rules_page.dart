import 'package:flutter/material.dart';
import 'package:flutter_md/flutter_md.dart';
import 'package:kaehne_und_kraken/data/app_data.dart';
import 'package:kaehne_und_kraken/views/widgets/content/text_sections/text_section_root.dart';

String rulesPath = 'assets/markdown/rules.md';

class RulesPage extends StatefulWidget {
  const RulesPage({super.key});

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  @override
  void initState() {
    super.initState();
  }

  Table? table;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var section in AppData.ruleSections)
            TextSectionWidget(
              section: section,
              display: TextSectionDisplay.expandable,
            ),
        ],
      ),
    );
  }

  MarkdownWidget get(String str) {
    return MarkdownWidget(markdown: Markdown.fromString(str));
  }
}
