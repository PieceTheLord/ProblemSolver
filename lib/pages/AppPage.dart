import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_educational_shop/pages/Authpage.dart';
import 'package:flutter_educational_shop/pages/MainPage.dart';
import 'package:flutter_educational_shop/services/appwrite_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppPage extends ConsumerStatefulWidget {
  const AppPage({super.key});

  @override
  _AppPageState createState() => _AppPageState();
}

final isAuth = StateProvider<User?>((ref) => null);

class _AppPageState extends ConsumerState<AppPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getAuth();
  }

  Future<void> _getAuth() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final user = await appwrite
          .getCurrentUser(); //Or restore the user using token
      ref.read(isAuth.notifier).state = user;
    } catch (e) {
      ref.read(isAuth.notifier).state = null;
    } finally {
      setState(() {
        _isLoading = false;
      });
      print(await appwrite.getCurrentUser());
    }
  }

  @override
  Widget build(BuildContext context) {
    final authUser = ref.watch(isAuth);

    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (authUser == null) {
      return Authpage();
    }

    return MainPage();
  }
}
