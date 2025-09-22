import 'package:flutter/material.dart';
import 'package:flutter_educational_shop/pages/KpiCardData.dart';

class KpiDataCard extends StatelessWidget {
  final String title;
  final String goal;
  final String createdAt;
  final String updatedAt;

  const KpiDataCard({
    super.key,
    required this.title,
    required this.goal,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 2.0,
          shadowColor: Colors.grey,
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => KpiCardData(title: title),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title: $title",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Goal: $goal"),
            const SizedBox(height: 8),
            Text("Created at: $createdAt"),
            Text("Updated at: $updatedAt"),
          ],
        ),
      ),
    );
  }

  void toList() {}
}
