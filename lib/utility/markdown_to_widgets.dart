import 'package:flutter/widgets.dart';
import 'package:flutter_md/flutter_md.dart';
import 'package:kaehne_und_kraken/views/widgets/displays/formatted_text.dart';
import 'package:kaehne_und_kraken/views/widgets/rule_widget.dart';

class MarkdownToWidgets {
  static const int ruleHeadLevel = 3;

  static List<Widget> convert(
    Markdown md,
    BuildContext context,
  ) {
    List<Widget> widgets = List.empty(growable: true);
    var blocks = md.blocks;
    int i = 0;

    while (i < blocks.length) {
      if (checkHeading(blocks[i]) <= ruleHeadLevel) {
        int j = i + 1;

        while (j < blocks.length && checkHeading(blocks[j]) <= ruleHeadLevel) {
          widgets.add(
            RuleWidget(
              title: blocks[i].text,
              child: TextFormatting.text(
                blocks[j].text,
                Formats.bodyMedium,
              ),
            ),
          );
          j++;
        }
        //==INC i==//
        i = j;
      } else {
        i++;
      }
    }

    return widgets;
  }

  static int checkHeading(MD$Block block) {
    return (block is MD$Heading) ? block.level : 7;
  }
}
