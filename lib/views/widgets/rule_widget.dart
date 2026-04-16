import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/views/widgets/displays/formatted_text.dart';
import 'package:kaehne_und_kraken/views/widgets/decoration/statblock_tile.dart';

class RuleWidget extends StatelessWidget {
  final String title;
  final Widget child;
  const RuleWidget({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return StatblockTile(
      children: [
        TextFormatting.text(
          title,
          Formats.titleMedium,
          context,
        ),
        child,
      ],
    );
  }
}
