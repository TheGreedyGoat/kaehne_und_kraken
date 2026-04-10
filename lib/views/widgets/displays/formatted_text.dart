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
  static Widget text(String data, Formats format, BuildContext context) {
    return Text(data, style: _styleFrom(format, context));
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

  static TextStyle? _styleFrom(Formats format, BuildContext context) {
    switch (format) {
      case Formats.titleLarge:
        return Theme.of(context).textTheme.titleLarge;
      case Formats.titleMedium:
        return Theme.of(context).textTheme.titleMedium;
      case Formats.titleSmall:
        return Theme.of(context).textTheme.titleSmall;
      case Formats.bodyLarge:
        return Theme.of(context).textTheme.bodyLarge;
      case Formats.bodyMedium:
        return Theme.of(context).textTheme.bodyMedium;
      case Formats.bodySmall:
        return Theme.of(context).textTheme.bodySmall;
    }
  }

  static String signedNumber(num number) {
    return '${number >= 0 ? '+' : ''}$number';
  }
}
