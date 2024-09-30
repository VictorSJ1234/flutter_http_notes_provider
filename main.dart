import 'package:flutter/material.dart';
import 'package:inventi_flutter_exam/home/random_string_provider.dart';
import 'package:inventi_flutter_exam/login/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:inventi_flutter_exam/routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RandomStringProvider()), // Add the RandomStringProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
