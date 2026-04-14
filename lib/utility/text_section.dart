import 'package:flutter_md/flutter_md.dart';
import 'package:markdown/markdown.dart';

enum HeadingLevel { h1, h2, h3, h4, h5, h6, none }

class TextSection {
  late final int level;
  late final String title;
  late List<TextSection> subsections;

  late List<MD$Block> content;

  TextSection({
    required MD$Heading headingBlock,
    this.subsections = const [],
    this.content = const [],
  }) {
    level = headingBlock.level;
    title = headingBlock.text;
  }

  /// TextSection without a heading
  TextSection.orphan({
    this.subsections = const [],
    this.content = const [],
  }) {
    level = -1;
    title = '';
  }
  //======================================================
  static List<TextSection> fromMDBlocks(List<MD$Block> blocks) {
    if (blocks.isEmpty) return [];

    List<TextSection> result = List.empty(growable: true);
    HeadingLevel mainLevel = checkHeadingType(blocks[0]);

    if (mainLevel == HeadingLevel.none) return [];

    int i = 0;

    while (i < blocks.length) {
      List<MD$Block> content = List.empty(growable: true);
      List<TextSection> subsections = List.empty(growable: true);
      MD$Heading currentMainHeading = blocks[i] as MD$Heading;

      int j = i + 1;
      while (j < blocks.length &&
          checkHeadingType(blocks[j]) == HeadingLevel.none) {
        content.add(blocks[j]);

        j++;
      } // end of orphans

      List<MD$Block> recursionBlocks = List.empty(growable: true);
      while (j < blocks.length) {
        var currentBlock = blocks[j];
        HeadingLevel currentLevel = checkHeadingType(currentBlock);

        if (currentLevel.index <= currentMainHeading.level) {
          break;
        }
        recursionBlocks.add(blocks[j]);
        j++;
      }
      subsections = fromMDBlocks(recursionBlocks);

      result.add(
        TextSection(
          headingBlock: currentMainHeading,
          subsections: subsections.reversed.toList(),
          content: content,
        ),
      );
      i = j;
    }
    return result; //.reversed.toList();
  }

  static HeadingLevel checkHeadingType(MD$Block block) {
    return (block is MD$Heading)
        ? HeadingLevel.values[block.level - 1]
        : HeadingLevel.none;
  }

  @override
  String toString() {
    String result = '\n${' ' * level} h$level :$title\n';
    for (var orph in content) {
      result += '${orph.text}\n';
    }
    for (var sub in subsections) {
      print(sub);
    }
    return result;
  }
}
