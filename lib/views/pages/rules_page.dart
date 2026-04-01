import 'package:flutter/material.dart';
import 'package:flutter_md/flutter_md.dart';
import 'package:kaehne_und_kraken/utility/file_loader.dart';
import 'package:kaehne_und_kraken/utility/md_parsers.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';

String rulesPath = 'assets/markdown/rules.md';

class RulesPage extends StatefulWidget {
  const RulesPage({super.key});

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  Markdown? _rulesMD;
  @override
  void initState() {
    super.initState();
    FileLoader.loadFile(path: rulesPath, callback: onRulesLoaded);
  }

  void onRulesLoaded(String data) {
    setState(() {
      _rulesMD = Markdown.fromString(data);
      if (_rulesMD != null) {
        for (var block in _rulesMD!.blocks) {
          if (block is MD$Table) {
            table = MyMDTable(block).toTableWidget();
            return;
          }
        }
      }
    });
  }

  Table? table;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: MarkdownWidget(
        markdown: _rulesMD ?? Markdown.fromString('# Nüscht'),
      ),
    );
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
