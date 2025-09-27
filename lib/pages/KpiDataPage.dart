import 'package:flutter/material.dart';
import 'package:flutter_educational_shop/features/appwrite_service.dart';
import 'package:flutter_educational_shop/models/ProgressBar.dart';
import 'package:flutter_educational_shop/store/states.dart';
import 'package:flutter_educational_shop/ui/ReturnBtn.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KpiDataPage extends ConsumerWidget {
  final String title;
  final String rowID;
  const KpiDataPage({super.key, required this.title, required this.rowID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            ElevatedButton(
              onPressed: () async {
                await appwrite.deleteCurrentKPI(rowID);
                await getKpis(ref);
                Navigator.pop(context);
              },
              child: Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }
}
