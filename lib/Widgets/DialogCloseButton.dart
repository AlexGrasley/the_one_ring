import 'package:flutter/material.dart';

class DialogCloseButton extends StatelessWidget
{
  const DialogCloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context)
  {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pop(),
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)
      ),
      child: const Text("close", style: TextStyle(color: Colors.white))
    );
  }
}