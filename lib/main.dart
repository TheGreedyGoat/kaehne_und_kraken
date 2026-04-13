import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/app_data.dart';
import 'package:kaehne_und_kraken/data/colors.dart';
import 'package:kaehne_und_kraken/views/widget_tree.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppData.load();
  runApp(
    MaterialApp(
      theme: ThemeData(
        dialogTheme: DialogThemeData(backgroundColor: noteColor),
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
          surface: noteColor,
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
}
