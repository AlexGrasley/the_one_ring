import 'package:flutter/material.dart';

class TextFormInput extends StatelessWidget
{
  final String initialValue;
  final String labelText;
  final bool isNumberEntry;
  final Function(String) onChanged;

  const TextFormInput({
    required this.initialValue,
    required this.labelText,
    required this.onChanged,
    this.isNumberEntry = false,
    super.key,
  });

  @override
  Widget build(BuildContext context)
  {
    return TextFormField(
      keyboardType: isNumberEntry? TextInputType.number : TextInputType.text,
      textAlign: TextAlign.center,
      initialValue: initialValue,
      style: const TextStyle(
        color: Colors.white,
        backgroundColor: Colors.transparent),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.red,
          backgroundColor: Colors.transparent,
        ),
        border: const UnderlineInputBorder(),
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onChanged: onChanged
    );
  }
}
