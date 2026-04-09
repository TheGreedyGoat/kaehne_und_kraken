import 'package:flutter/material.dart';
import 'package:kaehne_und_kraken/data/colors.dart';
import 'package:kaehne_und_kraken/utility/md_parsers.dart';
import 'package:kaehne_und_kraken/views/widgets/statblock/statblock_tile.dart';

class NumberInput extends StatefulWidget {
  final String? title;
  const NumberInput({super.key, this.title});

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  final TextEditingController _controller = TextEditingController();
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
              Row(
                children: [
                  _buildButton(
                    onPressed: () {},
                    child: Text(
                      'Schaden',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    backgroundColor: Colors.red,
                  ),
                  _buildButton(
                    onPressed: () {},
                    child: Text(
                      'Reparieren',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    backgroundColor: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required Function() onPressed,
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