import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';
import 'package:kaehne_und_kraken/views/pages/rules_page.dart';
import 'package:kaehne_und_kraken/views/pages/ship_creation.dart';
import 'package:kaehne_und_kraken/views/pages/ships_overview.dart';
import 'package:kaehne_und_kraken/views/widgets/decoration/statblock_border.dart';
import 'package:kaehne_und_kraken/views/widgets/general/app_bar_widget.dart';
import 'package:kaehne_und_kraken/views/widgets/general/navbar_widget.dart';

const List<Widget> pages = [ShipsOverview(), RulesPage()];
const List<String> pageTitles = ['Schiffe', 'Regelübersicht'];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return Scaffold(
          appBar: AppBarWidget(
            context: context,
            header: pageTitles[selectedPage],
          ),
          body: StatBlockBorder(child: pages[selectedPage]),

          bottomNavigationBar: NavbarWidget(),
          floatingActionButton: selectedPage == 0
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ShipCreation();
                        },
                      ),
                    );
                  },
                  shape: CircleBorder(),
                  child: Icon(Icons.add),
                )
              : null,
        );
      },
    );
  }
}
