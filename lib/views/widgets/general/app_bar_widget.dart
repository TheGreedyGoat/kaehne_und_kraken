import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/views/widgets/displays/formatted_text.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({
    super.key,
    super.actions,
    super.leading,
    super.bottom,
    String? subHeader,
    bool centerTitle = true,
    required BuildContext context,
    required String header,
  }) : super(
         flexibleSpace: Image.asset(
           'assets/images/parchment_bg_dark.png',
           fit: BoxFit.cover,
         ),

         centerTitle: centerTitle,
         title: TextFormatting.textSpan({
           header: Formats.titleLarge,
           ?subHeader: Formats.bodyMedium,
         }, context),

         //  Text(
         //    header,
         //    style: TextStyle(
         //      fontFamily: 'Mr Eaves',
         //      color: titleColor,
         //      fontWeight: FontWeight(700),
         //      fontSize: 30.0,
         //    ),
         //  ),
         backgroundColor: Colors.transparent,
       );
}
