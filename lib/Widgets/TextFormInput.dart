import 'package:flutter/material.dart';

class TextFormInput extends StatelessWidget {
  final String initialValue;
  final String labelText;
  final Function(String) onChanged;

  const TextFormInput({
    required this.initialValue,
    required this.labelText,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}