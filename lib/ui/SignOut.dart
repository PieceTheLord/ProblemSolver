import 'package:flutter/material.dart';
import 'package:flutter_educational_shop/pages/Authpage.dart';
import 'package:flutter_educational_shop/features/appwrite_service.dart';

class SignOut extends StatelessWidget {
  const SignOut({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await appwrite.account.deleteSession(sessionId: "current");
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
