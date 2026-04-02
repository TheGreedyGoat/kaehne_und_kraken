import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/colors.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({super.key, super.actions, required String header})
    : super(
        flexibleSpace: Image.asset(
          'assets/images/parchment_bg_dark.png',
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        title: Text(
          header,
          style: TextStyle(
            fontFamily: 'Mr Eaves',
            color: titleColor,
            fontWeight: FontWeight(700),
            fontSize: 30.0,
          ),
        ),
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 5.0),

          child: Container(
            decoration: BoxDecoration(border: Border.all()),
            child: Image.network(
              'https://tetra-cube.com/dnd/dndimages/statblockbar.jpg',
            ),
          ),
        ),
      );
}
