import 'package:flutter/material.dart';

class MyTable extends StatelessWidget {
  final List<List<String>> tableContent;
  const MyTable({super.key, required this.tableContent});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            for (var c in tableContent[0])
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(c, style: TextStyle(fontWeight: FontWeight(700))),
              ),
          ],
        ),
        for (int i = 1; i < tableContent.length; i++)
          TableRow(
            decoration: BoxDecoration(
              color: i % 2 == 1 ? Color(0xffe0e5c1) : null,
            ),
            children: [
              for (var c in tableContent[i])
                Padding(padding: const EdgeInsets.all(2.0), child: Text(c)),
            ],
          ),
      ],
    );
  }
}
