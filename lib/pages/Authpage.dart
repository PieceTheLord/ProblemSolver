import 'package:flutter/material.dart' hide Row;
import 'package:flutter_educational_shop/pages/AppPage.dart';
import 'package:flutter_educational_shop/services/appwrite_service.dart';

class Authpage extends StatefulWidget {
  const Authpage({super.key});

  @override
  State<Authpage> createState() => AuthpageState();
}

class AuthpageState extends State<Authpage> {
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
                  await Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => AppPage()));
                } catch (e) {
                  print("Sign-in error: $e");
                }
              },
              child: Text("SignIn"),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await appwrite.account.deleteSession(sessionId: "current");
                  await Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => AppPage()));
                } catch (e) {
                  print("Sign-in error: $e");
                }
              },
              child: Text("SignOut"),
            ),
          ],
        ),
      ),
    );
  }
}
