import 'package:crud_shop/presentation/screen/auth/login_screen.dart';
import 'package:crud_shop/presentation/screen/auth/singup_screen.dart';
import 'package:crud_shop/presentation/screen/home/home_screen.dart';
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
      ),

      GoRoute(
        path: '/signup',
        builder: (BuildContext context, GoRouterState state) {
          return const SignupScreen();
        }
      ),

      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        }
      )
    ]
  );
}