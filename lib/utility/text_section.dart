import 'package:flutter_md/flutter_md.dart';

enum HeadingLevel { h1, h2, h3, h4, h5, h6, none }

class TextSection {
  int get level => heading.level;
  late final MD$Heading heading;
  late List<TextSection> subsections;

  late List<MD$Block> content;

  static TextSection? _notFound;
  static TextSection get notFound {
    _notFound ??= TextSection(
      heading: MD$Heading(text: '404', level: 6, spans: []),
    );
    return _notFound!;
  }

  TextSection({
    required this.heading,
    this.subsections = const [],
    this.content = const [],
  });

  /// TextSection without a heading
  TextSection.orphan({
    this.subsections = const [],
    this.content = const [],
  }) : heading = MD$Heading(text: '', level: 1, spans: []);

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
          // Until first heading
          checkHeadingType(blocks[j]) == HeadingLevel.none) {
        if (blocks[j] is! MD$Spacer) {
          content.add(blocks[j]);
        }

        j++;
      } // end of orphans

      content.add(MD$Spacer());
      List<MD$Block> recursionBlocks = List.empty(growable: true);
      while (j < blocks.length) {
        var currentBlock = blocks[j];
        HeadingLevel currentLevel = checkHeadingType(currentBlock);

        if (currentLevel.index <= mainLevel.index) {
          break;
        }
        recursionBlocks.add(blocks[j]);
        j++;
      }

      subsections = fromMDBlocks(recursionBlocks);
      result.add(
        TextSection(
          heading: currentMainHeading,
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
    String result = '\n${' ' * level} h$level :$heading\n';
    for (var orph in content) {
      result += '${' ' * level}${orph.text}\n';
    }
    return result;
  }
}
