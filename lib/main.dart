import 'package:flutter/material.dart';

import 'package:hrms/routing/route_names.dart';
import 'package:hrms/storage/preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if user is logged in
  final isLoggedIn = await Preferences.isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: approuter(isLoggedIn),
    );
  }
}
