import 'package:crud_shop/config/router/app_router.dart';
import 'package:crud_shop/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Crud Shop',
        theme: AppTheme.themeData(),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
    );
  }
}