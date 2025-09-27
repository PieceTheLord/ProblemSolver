import 'package:flutter/material.dart';
import 'package:flutter_educational_shop/pages/AppPage.dart';
import 'package:flutter_educational_shop/store/states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Solver',
      home: AppPage(),
      theme: FlexThemeData.light(scheme: FlexScheme.aquaBlue),
      darkTheme: ThemeData.dark(),
      themeMode: ref.watch(themeProvider) ? ThemeMode.dark : ThemeMode.light,
    );
  }
}

void main() {
  runApp(ProviderScope(child: const MyApp()));
}
