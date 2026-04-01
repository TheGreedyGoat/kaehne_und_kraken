import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  final Widget child;
  const BodyWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/parchment_bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(padding: EdgeInsets.all(8.0), child: child),
    );
  }
}
