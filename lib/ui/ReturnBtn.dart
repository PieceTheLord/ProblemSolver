import 'package:flutter/material.dart';

class ReturnBtn extends StatelessWidget {
  const ReturnBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back),
    );
  }
}
