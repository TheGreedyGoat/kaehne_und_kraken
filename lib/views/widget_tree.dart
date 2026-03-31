import 'package:flutter/material.dart';
import 'package:flutter_md/flutter_md.dart';
import 'package:kaehne_und_kraken/views/pages/rules_page.dart';

Color titleColor = Color(0xff58180d);

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: Image.asset(
          'assets/images/parchment_bg.png',
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        title: Text(
          'Rules Reference',
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
            decoration: BoxDecoration(
              border: BorderDirectional(
                bottom: BorderSide(width: 5.0, color: titleColor),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/parchment_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: MarkdownTheme(
          data: MarkdownThemeData(
            textStyle: TextStyle(fontFamily: 'Scaly Sans', color: Colors.black),
            h1Style: TextStyle(
              fontFamily: 'Mr Eaves',
              color: titleColor,
              fontSize: 36,
              fontWeight: FontWeight(700),
            ),
            h2Style: TextStyle(
              fontFamily: 'Mr Eaves',
              color: titleColor,
              fontSize: 36,
              fontWeight: FontWeight(700),
            ),
            h3Style: TextStyle(
              fontFamily: 'Mr Eaves',
              color: titleColor,
              fontSize: 24,
              fontWeight: FontWeight(700),
            ),
            h4Style: TextStyle(
              fontFamily: 'Mr Eaves',
              color: titleColor,
              fontSize: 24,
              fontWeight: FontWeight(700),
            ),
            surfaceColor: Color.fromARGB(255, 207, 216, 147),
            dividerColor: Colors.transparent,
          ),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RulesPage(),
          ),
        ),
      ),
    );
  }
}
