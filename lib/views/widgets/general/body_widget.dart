import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/views/widgets/decoration/statblock_border.dart';

class BodyWidget extends StatelessWidget {
  final Widget child;
  const BodyWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StatBlockBorder(child: child);
  }
}
