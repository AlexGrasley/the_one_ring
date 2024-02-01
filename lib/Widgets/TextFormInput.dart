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
      textAlign: TextAlign.center,
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          backgroundColor: Theme.of(context).canvasColor,
        ),
        border: const UnderlineInputBorder(),
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onChanged: onChanged,
    );
  }
}
