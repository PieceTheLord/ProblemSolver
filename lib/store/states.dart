import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/models.dart';

final isAuth = StateProvider<User?>((ref) => null);

final themeProvider = StateProvider<bool>((red) => true);
