import 'package:flutter/material.dart';

class StatBlockBorder extends StatelessWidget {
  final Widget child;
  final String backgroundImagePath;
  final double? width, height;
  const StatBlockBorder({
    super.key,
    required this.child,
    this.backgroundImagePath = 'assets/images/parchment_bg.png',
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImagePath),
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
      ),
    );
    ;
  }
}
