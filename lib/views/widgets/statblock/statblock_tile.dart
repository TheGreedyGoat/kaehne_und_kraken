import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/views/widgets/separator_wedge.dart';

class StatblockTile extends StatelessWidget {
  final List<Widget> children;
  StatblockTile({super.key, required this.children}) {
    children.add(SeparatorWedge());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
