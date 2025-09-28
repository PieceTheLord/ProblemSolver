import 'package:flutter/material.dart';
import 'package:flutter_educational_shop/store/states.dart';
import 'package:flutter_educational_shop/ui/createKPIBtn.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateKPIWidget extends ConsumerWidget {
  const CreateKPIWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: "Title",
              border: OutlineInputBorder(),
            ),
            onChanged: (text) =>
                ref.read(kpiTitleProvider.notifier).state = text,
          ),
          SizedBox(height: 10),
          TextField(
            decoration: const InputDecoration(
              labelText: "Goal",
              border: OutlineInputBorder(),
            ),
            onChanged: (text) =>
                ref.read(kpiGoalProvider.notifier).state = text,
          ),
          CreateKPIBtn(),
        ],
      ),
    );
  }
}
