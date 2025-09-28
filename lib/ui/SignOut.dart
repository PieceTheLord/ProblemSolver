import 'package:flutter/material.dart';
import 'package:flutter_educational_shop/pages/Authpage.dart';
import 'package:flutter_educational_shop/store/states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignOut extends ConsumerWidget {
  const SignOut({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await signOut(ref);
          await Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => Authpage()));
        } catch (e) {
          print("Sign-in error: $e");
        }
      },
      child: Text("SignOut"),
    );
  }
}
