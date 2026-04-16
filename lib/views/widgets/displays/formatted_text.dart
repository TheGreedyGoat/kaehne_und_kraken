import 'package:flutter/material.dart';

enum Formats {
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
}

class TextFormatting {
  static Widget text(
    String data,
    Formats format,
    BuildContext context, [
    int? fontWeight,
  ]) {
    return Text(data, style: _styleFrom(format, context, fontWeight));
  }

  static Widget textSpan(Map<String, Formats> data, BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          for (var key in data.keys)
            TextSpan(text: key, style: _styleFrom(data[key]!, context)),
        ],
      ),
    );
  }

  static TextStyle? _styleFrom(
    Formats format,
    BuildContext context, [
    int? fontWeight,
  ]) {
    TextStyle? style;
    switch (format) {
      case Formats.titleLarge:
        style = Theme.of(context).textTheme.titleLarge;
      case Formats.titleMedium:
        style = Theme.of(context).textTheme.titleMedium;
      case Formats.titleSmall:
        style = Theme.of(context).textTheme.titleSmall;
      case Formats.bodyLarge:
        style = Theme.of(context).textTheme.bodyLarge;
      case Formats.bodyMedium:
        style = Theme.of(context).textTheme.bodyMedium;
      case Formats.bodySmall:
        style = Theme.of(context).textTheme.bodySmall;
    }

    return fontWeight == null
        ? style
        : style!.copyWith(fontWeight: FontWeight(fontWeight));
  }

  static String signedNumber(num number) {
    return '${number >= 0 ? '+' : ''}$number';
  }
}
