import 'package:flutter/material.dart';

class MyDropDown<T> extends StatefulWidget {
  final ValueNotifier<T?> listener;
  final List<DropdownMenuItem<T>> items;
  const MyDropDown({super.key, required this.items, required this.listener});

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState<T> extends State<MyDropDown> {
  late ValueNotifier<T?> listener;
  @override
  void initState() {
    listener = widget.listener as ValueNotifier<T?>;
    super.initState();
  }

  T? value;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      style: Theme.of(context).textTheme.bodyLarge,
      value: value ?? widget.listener.value,
      dropdownColor: Colors.white,
      items: widget.items,
      onChanged: (newValue) {
        setState(() {
          widget.listener.value = newValue;
        });
      },
    );
  }
}
