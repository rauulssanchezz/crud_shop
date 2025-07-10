import 'package:crud_shop/config/menu_items/menu_item.dart';
import 'package:crud_shop/presentation/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final NavigationProvider navigationProvider = context.watch<NavigationProvider>();

    return BottomNavigationBar(
      
      items: menuItems,
      currentIndex: navigationProvider.currentIndex,
      onTap: (index) {
        navigationProvider.setIndex(index);
        context.go(routes[index]);
      },
    );
  }
}