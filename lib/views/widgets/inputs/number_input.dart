import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/styles/colors.dart';
import 'package:kaehne_und_kraken/views/widgets/decoration/statblock_tile.dart';

class NumberInput extends StatefulWidget {
  final String? title;
  final List<NumInputAction> actions;
  const NumberInput({super.key, this.title, required this.actions});

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  final TextEditingController _controller = TextEditingController();
  List<NumInputAction> get actions => widget.actions;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _appendNumber(int number) {
    setState(() {
      _controller.text += number.toString();
    });
  }

  void _removeNumber() {
    String num = _controller.text;
    if (num.isNotEmpty) {
      _controller.text = num.substring(0, num.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        StatblockTile(
          children: [
            Text(
              widget.title ?? 'Eingabe',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        SizedBox(
          child: Column(
            children: [
              SizedBox(height: 5.0),
              TextFormField(
                textAlign: TextAlign.end,
                controller: _controller,
                readOnly: true,
                decoration: InputDecoration(
                  label: Text(
                    'Schaden/ Reparatur',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  suffix: Text('SP'),

                  // filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 5.0),
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              SizedBox(height: 16),
              GridView.count(
                childAspectRatio: 2,
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  for (int i = 1; i <= 9; i++) _buildNumberButton(i),
                  Container(),
                  _buildNumberButton(0),
                  _buildButton(
                    onPressed: () => _removeNumber(),
                    child: Icon(Icons.backspace, color: Colors.black),
                  ),
                ],
              ),
              GridView.count(
                childAspectRatio: 2,
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  for (var action in actions) _buildActionButton(action),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required void Function() onPressed,
    required Widget child,
    Color? backgroundColor,
  }) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              backgroundColor ?? const Color.fromARGB(255, 235, 195, 142),
          shape: BeveledRectangleBorder(
            side: BorderSide(color: titleColor, width: 1.0),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }

  Widget _buildActionButton(NumInputAction action) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              action.backgroundColor ??
              const Color.fromARGB(255, 235, 195, 142),
          shape: BeveledRectangleBorder(
            side: BorderSide(color: titleColor, width: 1.0),
          ),
        ),
        onPressed: () {
          action.param = parseInput();
          Navigator.pop(context, action);
        },
        child: action.label,
      ),
    );
  }

  Widget _buildNumberButton(int number) {
    return _buildButton(
      child: Text(
        number.toString(),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onPressed: () {
        _appendNumber(number);
      },
    );
  }

  int parseInput() {
    return int.tryParse(_controller.text) ?? 0;
  }
}

class NumInputAction {
  late Function(int) onPressed;

  late Widget label;
  late Color? backgroundColor;
  late int? param;
  NumInputAction({
    this.backgroundColor,
    required this.label,
    required this.onPressed,
  });

  void call() {
    if (param != null)
      onPressed(param!);
    else
      print('No Parameter given');
  }
}

// ElevatedButton(
//         style: buttonstyle,
//         onPressed: () {
//           _appendNumber(number);
//         },
//         child: Text(
//           number.toString(),
//           style: Theme.of(
//             context,
//           ).textTheme.bodyLarge?.copyWith(color: Colors.black),
//         ),
//       ),
