import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/views/widgets/decoration/statblockBorder.dart';
import 'package:kaehne_und_kraken/views/widgets/statblock/statblock_tile.dart';

class BodyWidget extends StatelessWidget {
  final Widget child;
  const BodyWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StatBlockBorder(child: child);
  }
}
