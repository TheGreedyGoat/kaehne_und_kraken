import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/views/widgets/statblock/statblock_tile.dart';

class PercentageBar extends StatefulWidget {
  final double min;
  final double max;
  final double initValue;
  final double totalWidth;
  const PercentageBar({
    super.key,
    required this.min,
    required this.max,
    required this.initValue,
    this.totalWidth = 300,
  });

  @override
  State<PercentageBar> createState() => _PercentageBarState();
}

class _PercentageBarState extends State<PercentageBar> {
  double get min => widget.min;
  double get max => widget.max;
  double get totalWidth => widget.totalWidth;
  late double value;

  @override
  void initState() {
    value = widget.initValue;
    print(
      ('min: $min, max: $max, value: $value, ${totalWidth * percentage()}'),
    );
    assert(
      _validate(),
      'Invalid values on percentage bar! (min: $min, max: $max, value: $value)',
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LinearProgressIndicator(
            value: percentage(),
            minHeight: 10,
            backgroundColor: Colors.red,
            color: Colors.green,
          ),
        ),
        subtitle: Text('SP: ${value.floor()}/${max.floor()}'),
      ),
    );
  }

  bool _validate() {
    return min < max && value >= min && value <= max;
  }

  double percentage() {
    return (value - min) / (max - min);
  }
}
