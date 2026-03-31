import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/views/widget_tree.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(dataTableTheme: DataTableThemeData(decoration: null)),
      home: WidgetTree(),
    ),
  );
}
