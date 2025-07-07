import 'package:crud_shop/config/router/app_router.dart';
import 'package:crud_shop/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crud Shop',
      theme: AppTheme.themeData(),
      home: MaterialApp.router(
        routerConfig: AppRouter.router,
      )
    );
  }
}