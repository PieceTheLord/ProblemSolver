import 'package:flutter/material.dart';
import 'package:flutter_educational_shop/store/states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangeThemeBtn extends ConsumerWidget {
  const ChangeThemeBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () => ref.read(themeProvider.notifier).state = !ref
          .read(themeProvider.notifier)
          .state,
      icon: Icon(
        ref.read(themeProvider.notifier).state
            ? Icons.dark_mode
            : Icons.light_mode,
      ),
    );
  }
}
