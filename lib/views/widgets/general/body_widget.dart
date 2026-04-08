import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  final Widget child;
  const BodyWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/parchment_bg.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(padding: EdgeInsets.all(8.0), child: child),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: Image.network(
                'https://tetra-cube.com/dnd/dndimages/statblockbar.jpg',
              ),
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: Image.network(
                'https://tetra-cube.com/dnd/dndimages/statblockbar.jpg',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
