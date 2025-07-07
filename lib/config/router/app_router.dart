import 'package:crud_shop/presentation/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    routes: <RouteBase> [
      GoRoute( 
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        }
      )
    ]
  );
}