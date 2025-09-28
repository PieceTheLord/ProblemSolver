import 'package:flutter/material.dart';
import 'package:flutter_educational_shop/features/appwrite_service.dart';
import 'package:flutter_educational_shop/store/states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateKPIBtn extends ConsumerWidget {
  const CreateKPIBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(kpiTitleProvider);
    final goal = ref.watch(kpiGoalProvider);

    return ElevatedButton(
      onPressed: () async {
        await appwrite.insertKpiData(title: title, goal: goal);
        await getKpis(ref);
      },
      child: Text("Create KPI"),
    );
  }
}
