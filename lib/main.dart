import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_shop/config/router/app_router.dart';
import 'package:crud_shop/config/theme/app_theme.dart';
import 'package:crud_shop/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider(db: FirebaseFirestore.instance))
      ],
      child: const MyApp(),
    )
  );
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