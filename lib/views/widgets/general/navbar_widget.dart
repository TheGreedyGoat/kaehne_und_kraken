import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/parchment_bg_dark.png',
            fit: BoxFit.fitWidth,
          ),

          ValueListenableBuilder(
            valueListenable: selectedPageNotifier,
            builder: (context, int selectedPage, child) {
              return NavigationBar(
                backgroundColor: Colors.transparent,
                destinations: [
                  NavigationDestination(
                    icon: Icon(Icons.home_filled),
                    label: 'ships',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.menu_book_sharp),
                    label: 'rules',
                  ),
                ],
                onDestinationSelected: (int value) {
                  selectedPageNotifier.value = value;
                },
                selectedIndex: selectedPage,
              );
            },
          ),
        ],
      ),
    );
  }
}
