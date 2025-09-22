import 'package:flutter/material.dart';

class KpiCardData extends StatelessWidget {
  final String title;
  const KpiCardData({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
        ],
      ),
    );
  }
}
