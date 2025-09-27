import 'package:appwrite/models.dart' show Row;
import 'package:flutter/material.dart' hide Row;

class UserDataCard extends StatelessWidget {
  final Row row;

  const UserDataCard({super.key, required this.row});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Email: ${row.data['email'] ?? "N/A"}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Password: ${row.data['password'] ?? "N/A"}"),
            const SizedBox(height: 8),
            Text("Created at: ${row.data['created_at'] ?? "N/A"}"),
          ],
        ),
      ),
    );
  }
}
