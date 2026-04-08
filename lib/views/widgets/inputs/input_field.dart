import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextInputType type;
  final String label;
  final Function(String value) onEditingComplete;
  final bool isVertical;
  final TextStyle? inputStyle;
  final TextStyle? labelStyle;
  final bool centerInput;
  const InputField({
    super.key,
    this.type = TextInputType.text,
    required this.label,
    required this.onEditingComplete,
    this.isVertical = false,
    this.inputStyle,
    this.labelStyle,
    this.centerInput = false,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  String get label => widget.label;
  TextInputType? get type => widget.type;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        //===TEXT FIELD===//
        subtitle: TextFormField(
          style: widget.inputStyle ?? Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            label: Text(label, style: widget.inputStyle),

            // filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 5.0),
              borderRadius: BorderRadius.zero,
            ),
          ),
          controller: controller,
          keyboardType: type,
          onChanged: (value) {
            widget.onEditingComplete(controller.text);
          },
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
          onTapOutside: (value) {
            FocusScope.of(context).unfocus();
          },
        ),
      ),
    );
  }
}
