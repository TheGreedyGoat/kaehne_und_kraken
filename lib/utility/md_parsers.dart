import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_md/flutter_md.dart';

void parseTable(MD$Table md) {
  print(md.header.cells[0][0].text);
}

const Color tableColor = Color.fromARGB(255, 207, 216, 147);

class MyMDTable {
  List<String> header = List.empty(growable: true);
  List<List<String>> rows = List.empty(growable: true);
  MyMDTable(MD$Table tableBlock) {
    for (var item in tableBlock.header.cells) {
      header.add(item[0].text);
    }
    for (var row in tableBlock.rows) {
      List<String> cRow = List.empty(growable: true);
      rows.add(cRow);
      for (var cell in row.cells) {
        cRow.add(cell[0].text);
      }
    }
  }

  Table toTableWidget() {
    return Table(
      children: [
        TableRow(
          children: [
            for (String head in header)
              TableCell(
                child: Text(
                  head,
                  style: TextStyle(fontWeight: FontWeight(700)),
                ),
              ),
          ],
        ),
        //var row in rows
        for (int i = 0; i < rows.length; i++)
          TableRow(
            children: [
              for (var cell in rows[i])
                TableCell(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: Text(cell),
                    ),
                  ),
                ),
            ],
            decoration: BoxDecoration(color: i % 2 == 1 ? tableColor : null),
          ),
      ],
    );
  }
}
