import 'package:flutter/material.dart';

class NumberInput extends StatefulWidget {
  const NumberInput({super.key});

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void appendNumber(int number) {
    setState(() {
      _controller.text += number.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          TextField(controller: _controller, readOnly: true),
          SizedBox(height: 16),
          GridView.count(
            childAspectRatio: 1,
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              for (int i = 1; i <= 9; i++) _buildNumberButton(i),
              Container(),
              _buildNumberButton(0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumberButton(int number) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: TextButton(
        onPressed: () {
          appendNumber(number);
        },
        child: Text(number.toString()),
      ),
    );
  }
}
