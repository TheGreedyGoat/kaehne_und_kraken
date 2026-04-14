import 'package:flutter/material.dart';
import 'package:flutter_md/flutter_md.dart';
import 'package:kaehne_und_kraken/data/app_data.dart';
import 'package:kaehne_und_kraken/views/widgets/displays/formatted_text.dart';
import 'package:kaehne_und_kraken/views/widgets/statblock/statblock_tile.dart';

String rulesPath = 'assets/markdown/rules.md';

class RulesPage extends StatefulWidget {
  const RulesPage({super.key});

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  // Map<String, Map<String, String>> get rules => AppData.gameRules;
  @override
  void initState() {
    super.initState();
  }

  Table? table;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // for (var sectionTitle in rules.keys)
          //   StatblockTile(
          //     children: [
          //       TextFormatting.text(sectionTitle, Formats.titleLarge, context),
          //       for (String ruleTitle in rules[sectionTitle]!.keys)
          //         TextFormatting.textSpan({
          //           '$ruleTitle\n': Formats.titleMedium,
          //           rules[sectionTitle]![ruleTitle]!: Formats.bodyMedium,
          //         }, context),
          //     ],
          //   ),
        ],
      ),
    );
  }

  MarkdownWidget get(String str) {
    return MarkdownWidget(markdown: Markdown.fromString(str));
  }
}

// class RulesPageStl extends StatelessWidget {
//   RulesPageStl({super.key}) {
//     FileLoader.loadFile(path: rulesPath, callback: onRulesLoaded);
//   }

//   void onRulesLoaded(String data) {
//     var widgets = List<Widget>.empty(growable: true);
//     Markdown md = Markdown.fromString(data);

//     for (var block in md.blocks) {
//       if (block is MD$Table) {
//         widgets.add(MyMDTable(block).toTableWidget());
//       } else {
//         widgets.add(
//           MarkdownWidget(markdown: Markdown.fromString(block.toString())),
//         );
//       }
//     }
//     rulesWidgetsNotifier.value = widgets;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: ValueListenableBuilder(
//         valueListenable: rulesWidgetsNotifier,
//         builder: (context, widgets, child) {
//           return Column(children: [for (var w in widgets) w]);
//         },
//       ),
//     );
//   }
// }
