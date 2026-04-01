import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/utility/value_notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all()),
          child: Image.network(
            'https://tetra-cube.com/dnd/dndimages/statblockbar.jpg',
          ),
        ),
        Stack(
          children: [
            SizedBox(
              height: 80,
              width: double.infinity,
              child: Image.asset(
                'assets/images/parchment_bg_dark.png',
                fit: BoxFit.fitWidth,
              ),
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
      ],
    );
  }
}
