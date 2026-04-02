import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/colors.dart';
import 'package:kaehne_und_kraken/data/saves/json_loader.dart';
import 'package:kaehne_und_kraken/views/widget_tree.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: UnderlineInputBorder(),
        ),
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: const Color.fromARGB(188, 122, 69, 48),
          onPrimary: Colors.white,
          secondary: const Color.fromARGB(188, 122, 69, 48),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.red,
          surface: Colors.transparent,
          onSurface: Colors.black,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Mr Eaves',
            fontSize: 30.0,
            fontWeight: FontWeight(700),
            color: titleColor,
          ),
          titleMedium: TextStyle(
            fontFamily: 'Mr Eaves',
            fontSize: 20.0,
            fontWeight: FontWeight(700),
          ),
          titleSmall: TextStyle(
            fontFamily: 'Scaly Sans',
            color: titleColor,
            fontSize: 15,
            fontWeight: FontWeight(700),
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Scaly Sans',
            fontWeight: FontWeight(700),
          ),
          bodyMedium: TextStyle(fontFamily: 'Scaly Sans'),
          bodySmall: TextStyle(fontFamily: 'Scaly Sans'),
        ),
      ),
      home: WidgetTree(),
    ),
  );
  testWrite();
}

Future<void> testWrite() async {
  await JsonLoader.writeFile("Hello world!", "hello_world", 'txt');
  print(await JsonLoader.readFile("hello_world", 'txt'));
}
