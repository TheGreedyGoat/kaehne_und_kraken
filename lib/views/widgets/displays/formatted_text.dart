import 'package:flutter/material.dart';

enum Formats {
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
}

class FormattedText extends StatelessWidget {
  final String data;
  final Formats format;
  const FormattedText(this.data, this.format, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(data, style: _styleFrom(format, context));
  }

  TextStyle? _styleFrom(Formats format, BuildContext context) {
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
}
