import 'package:flutter_educational_shop/features/appwrite_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/models.dart';

final isAuth = StateProvider<User?>((ref) => null);

final themeProvider = StateProvider<bool>((red) => true);

final kpisProvider = StateProvider<List<Row>>((ref) => []);

Future<void> getKpis(WidgetRef ref) async {
  List<Row> kpisData = (await appwrite.getAllKPIs(
    email: ref.read(isAuth.notifier).state!.email,
  )).cast<Row>();
  ref.read(kpisProvider.notifier).state = kpisData;
}

Future<void> signOut(WidgetRef ref) async {
  await appwrite.logout();
  ref.read(isAuth.notifier).state = null;
  clearKPIs(ref);
}

void clearKPIs(WidgetRef ref) {
  ref.read(kpisProvider.notifier).state = [];
}

final kpiTitleProvider = StateProvider<String>((ref) => '');
final kpiGoalProvider = StateProvider<String>((ref) => '');
