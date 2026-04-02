import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextInputType type;
  final String label;
  final Function(String value) onEditingComplete;
  final bool isVertical;
  final TextStyle? inputStyle;
  final TextStyle? labelStyle;
  const InputField({
    super.key,
    this.type = TextInputType.text,
    required this.label,
    required this.onEditingComplete,
    this.isVertical = false,
    this.inputStyle,
    this.labelStyle,
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
        subtitle: TextField(
          style: widget.inputStyle ?? Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            filled: true,
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
        ),
        title: widget.isVertical
            ? Inputlabel(
                style:
                    widget.labelStyle ??
                    Theme.of(context).textTheme.titleSmall!,
                label: label,
              )
            : null,
        leading: widget.isVertical
            ? null
            : Inputlabel(
                style:
                    widget.labelStyle ??
                    Theme.of(context).textTheme.titleSmall!,
                label: label,
              ),
      ),
    );
  }
}

class Inputlabel extends StatelessWidget {
  final TextStyle style;
  final String label;
  const Inputlabel({super.key, required this.style, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label, textAlign: TextAlign.center, style: style);
  }
}
