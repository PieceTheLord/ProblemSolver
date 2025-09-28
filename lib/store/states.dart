import 'package:flutter_educational_shop/features/appwrite_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/models.dart';

final isAuth = StateProvider<User?>((ref) => null);

final themeProvider = StateProvider<bool>((red) => true);

final kpisProvider = StateProvider<List<Row>>((ref) => []);

Future<void> getKpis(WidgetRef ref) async {
  List<Row> kpisData = (await appwrite.getAllKPIs()).cast<Row>();
  ref.read(kpisProvider.notifier).state = kpisData;
}

final kpiTitleProvider = StateProvider<String>((ref) => '');
final kpiGoalProvider = StateProvider<String>((ref) => '');
