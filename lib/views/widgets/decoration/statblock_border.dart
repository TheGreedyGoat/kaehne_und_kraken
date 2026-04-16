import 'package:flutter/material.dart';

class StatBlockBorder extends StatelessWidget {
  final Widget child;
  final bool dark;
  late final String backgroundImagePath;
  final double? width, height;
  StatBlockBorder({
    super.key,
    required this.child,
    this.dark = false,
    String? backgroundImagePath,
    this.width,
    this.height,
  }) {
    this.backgroundImagePath =
        backgroundImagePath ??
        'assets/images/parchment_bg${dark ? '_dark' : ''}.png';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isBounded =
            constraints.hasBoundedWidth && constraints.hasBoundedHeight;
        return SizedBox(
          width: width,
          height: height,
          child: Stack(
            fit: isBounded ? StackFit.expand : StackFit.loose,
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(backgroundImagePath),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: child,
                ),
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
      },
    );
  }
}
