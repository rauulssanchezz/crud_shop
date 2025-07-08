import 'package:crud_shop/presentation/screen/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute( 
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        }
      )
    ]
  );
}