import 'package:flutter/material.dart' hide Row;
import 'package:flutter_educational_shop/pages/AppPage.dart';
import 'package:flutter_educational_shop/features/appwrite_service.dart';
import 'package:flutter_educational_shop/store/states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Authpage extends ConsumerStatefulWidget {
  const Authpage({super.key});

  @override
  _AuthpageState createState() => _AuthpageState();
}

class _AuthpageState extends ConsumerState<Authpage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await appwrite.signIn(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => AppPage()));
                } catch (e) {
                  print("Sign-in error: $e");
                }
              },
              child: Text("SignIn"),
            ),
            Text(ref.watch(isAuth)?.email ?? "Does not authenticated"),
          ],
        ),
      ),
    );
  }
}
