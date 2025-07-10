import 'package:crud_shop/presentation/screen/add_product/add_product.dart';
import 'package:crud_shop/presentation/screen/auth/login_screen.dart';
import 'package:crud_shop/presentation/screen/auth/singup_screen.dart';
import 'package:crud_shop/presentation/screen/shop/shop_screen.dart';
import 'package:crud_shop/presentation/widgets/navigation/custom_navigation_bar.dart';
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
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            body: child,
            bottomNavigationBar: CustomNavigationBar(), // Solo aquí
          );
        },
        routes: [
          GoRoute(
            path: '/shop',
            builder: (BuildContext context, GoRouterState state) {
              return const ShopScreen();
            }
          ),

          GoRoute(
            path: '/add_product',
            builder: (BuildContext context, GoRouterState state) {
              return const AddProduct();
            }
          ),
        ]
      ),
    ]
  );
}