import 'package:flutter/material.dart';
import 'package:flutter_educational_shop/models/ProgressBar.dart';
import 'package:flutter_educational_shop/ui/ReturnBtn.dart';

class KpiDataPage extends StatelessWidget {
  final String title;
  const KpiDataPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
            ReturnBtn(),
            TaskProgressBar(),
          ],
        ),
      ),
    );
  }
}
