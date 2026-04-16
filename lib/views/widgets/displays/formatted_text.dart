import 'package:flutter/material.dart';
import 'package:flutter_md/flutter_md.dart';
import 'package:kaehne_und_kraken/data/styles/colors.dart';

enum Formats {
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
}

class TextFormatting {
  static Widget text(
    String data,
    Formats format, [
    int? fontWeight,
  ]) {
    return Text(
      data,
      textAlign: TextAlign.left,
      style: _styleFrom(format, fontWeight),
    );
  }

  static Widget textSpan(Map<String, Formats> data) {
    return Text.rich(
      TextSpan(
        children: [
          for (var key in data.keys)
            TextSpan(text: key, style: _styleFrom(data[key]!)),
        ],
      ),
      textAlign: TextAlign.left,
    );
  }

  static TextStyle? _styleFrom(
    Formats format, [
    int? fontWeight,
  ]) {
    TextStyle? style = styles[format];

    return fontWeight == null
        ? style
        : style?.copyWith(fontWeight: FontWeight(fontWeight));
  }

  static String signedNumber(num number) {
    return '${number >= 0 ? '+' : ''}$number';
  }

  static Widget fromHeading(MD$Heading heading) {
    return text(
      heading.text,
      Formats.values[Formats.values.indexOf(Formats.h1) + heading.level - 1],
    );
  }

  static const Map<Formats, TextStyle> styles = {
    Formats.titleLarge: TextStyle(
      fontFamily: 'Mr Eaves',
      fontSize: 30.0,
      fontWeight: FontWeight(700),
      color: titleColor,
    ),
    Formats.titleMedium: TextStyle(
      fontFamily: 'Mr Eaves',
      fontSize: 20.0,
      fontWeight: FontWeight(700),
    ),
    Formats.titleSmall: TextStyle(
      fontFamily: 'Scaly Sans',
      color: titleColor,
      fontSize: 15,
      fontWeight: FontWeight(700),
    ),
    Formats.bodyLarge: TextStyle(
      fontFamily: 'Scaly Sans',
      fontWeight: FontWeight(700),
    ),
    Formats.bodyMedium: TextStyle(fontFamily: 'Scaly Sans'),
    Formats.bodySmall: TextStyle(fontFamily: 'Scaly Sans'),
    Formats.h1: TextStyle(
      fontFamily: 'Mr Eaves',
      fontSize: 30.0,
      fontWeight: FontWeight(700),
      color: titleColor,
    ),
    Formats.h2: TextStyle(
      fontFamily: 'Mr Eaves',
      fontSize: 25.0,
      fontWeight: FontWeight(700),
      color: Colors.black,
    ),
    Formats.h3: TextStyle(
      fontFamily: 'Mr Eaves',
      fontSize: 20.0,
      color: Colors.black,
    ),
    Formats.h4: TextStyle(
      fontFamily: 'Scaly Sans',
      fontSize: 20.0,
      fontWeight: FontWeight(700),
      color: titleColor,
    ),
    Formats.h5: TextStyle(
      fontFamily: 'Scaly Sans',
      fontSize: 18.0,
      fontWeight: FontWeight(700),
      color: Colors.black,
    ),
    Formats.h6: TextStyle(
      fontFamily: 'Scaly Sans',
      fontSize: 14.0,
      fontWeight: FontWeight(700),
      color: Colors.black,
    ),
  };
}
