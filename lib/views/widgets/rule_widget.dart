import 'package:flutter/material.dart';

class RuleWidget extends StatelessWidget {
  final String title;
  final Widget child;
  const RuleWidget({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          child,
        ],
      ),
    );
  }
}
