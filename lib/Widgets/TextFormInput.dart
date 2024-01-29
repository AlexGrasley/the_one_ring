import 'package:flutter/material.dart';

class TextFormInput extends StatelessWidget {
  final String labelText;
  final Function(String) onChanged;

  const TextFormInput({
    required this.labelText,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}