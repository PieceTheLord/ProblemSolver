import 'package:flutter/material.dart';
import 'package:flutter_educational_shop/pages/AppPage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AppPage());
  }
}

void main() {
  runApp(ProviderScope(child: const MyApp()));
}
