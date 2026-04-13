import 'package:flutter/material.dart';
import 'package:flutter_md/flutter_md.dart';
import 'package:kaehne_und_kraken/utility/file_loader.dart';
import 'package:kaehne_und_kraken/utility/md_parsers.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';
import 'package:kaehne_und_kraken/views/widgets/displays/formatted_text.dart';
import 'package:kaehne_und_kraken/views/widgets/statblock/statblock_tile.dart';

String rulesPath = 'assets/markdown/rules.md';

class RulesPage extends StatefulWidget {
  const RulesPage({super.key});

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  Map<String, Map<String, String>> rules = {};
  @override
  void initState() {
    super.initState();
    FileLoader.loadFile(path: rulesPath, callback: onRulesLoaded);
  }

  void onRulesLoaded(String data) {
    var blocks = Markdown.fromString(data).blocks;
    int i = 0;
    assert(
      isHeading(blocks[0], 2),
      'Rules File must start with an h2 ${blocks[i].text}',
    );
    while (i < blocks.length) {
      //=====SECTION TITLE=====//
      String sectionTitle = blocks[i].text;
      Map<String, String> currentSection = <String, String>{};
      int j = i + 1;
      while (j < blocks.length && !isHeading(blocks[j], 2)) {
        assert(
          isHeading(blocks[j], 3),
          'Rules section must begin with an h3: ${blocks[j].text}',
        );
        String ruleTitle = blocks[j].text;
        String ruleContent = '';
        int k = j + 1;
        while (k < blocks.length &&
            !isHeading(blocks[k], 2) &&
            !isHeading(blocks[k], 3)) {
          ruleContent += '${blocks[k].text}\n';
          k++;
        }
        currentSection[ruleTitle] = ruleContent;
        j = k;
      }
      rules[sectionTitle] = currentSection;
      i = j;
    }
  }

  bool isHeading(MD$Block block, int level) {
    return (block is MD$Heading) && block.level == level;
  }

  Table? table;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (var sectionTitle in rules.keys)
            StatblockTile(
              children: [
                TextFormatting.text(sectionTitle, Formats.titleLarge, context),
                for (String ruleTitle in rules[sectionTitle]!.keys)
                  TextFormatting.textSpan({
                    '$ruleTitle\n': Formats.titleMedium,
                    rules[sectionTitle]![ruleTitle]!: Formats.bodyMedium,
                  }, context),
              ],
            ),
        ],
      ),
    );
  }

  MarkdownWidget get(String str) {
    return MarkdownWidget(markdown: Markdown.fromString(str));
  }
}

class RulesPageStl extends StatelessWidget {
  RulesPageStl({super.key}) {
    FileLoader.loadFile(path: rulesPath, callback: onRulesLoaded);
  }

  void onRulesLoaded(String data) {
    var widgets = List<Widget>.empty(growable: true);
    Markdown md = Markdown.fromString(data);

    for (var block in md.blocks) {
      if (block is MD$Table) {
        widgets.add(MyMDTable(block).toTableWidget());
      } else {
        widgets.add(
          MarkdownWidget(markdown: Markdown.fromString(block.toString())),
        );
      }
    }
    rulesWidgetsNotifier.value = widgets;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ValueListenableBuilder(
        valueListenable: rulesWidgetsNotifier,
        builder: (context, widgets, child) {
          return Column(children: [for (var w in widgets) w]);
        },
      ),
    );
  }
}
