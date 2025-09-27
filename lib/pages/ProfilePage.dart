import 'package:flutter/material.dart';
import 'package:flutter_educational_shop/ui/SignOut.dart';
import 'package:flutter_educational_shop/store/states.dart';
import 'package:flutter_educational_shop/ui/ChangeThemeBtn.dart';
import 'package:flutter_educational_shop/ui/ReturnBtn.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Profilepage extends ConsumerWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(leading: ReturnBtn(), title: const Text('Profile')),
      body: Center(
        child: Column(
          children: [
            Text(ref.read(isAuth.notifier).state!.email),
            ChangeThemeBtn(),
            SignOut(),
          ],
        ),
      ),
    );
  }
}
