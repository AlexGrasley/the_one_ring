import 'package:flutter/material.dart';

class AddItemDialog extends StatelessWidget {
  const AddItemDialog({
    super.key,
    required this.title,
    required this.content,
  });

  final Widget content;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      insetAnimationDuration: const Duration(milliseconds: 1000),
      insetAnimationCurve: Curves.easeInCubic,
      backgroundColor: const Color.fromRGBO(4, 4, 4, 0.2),
      child: content,
    );
  }
}