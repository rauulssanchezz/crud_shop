import 'package:flutter/material.dart';

const List<BottomNavigationBarItem> menuItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.store_outlined),
    label: 'Tienda'
  ),

  BottomNavigationBarItem(
    icon: Icon(Icons.add_box_outlined),
    label: 'Añadir producto',
  ),
];
const List<String> routes = [
  '/shop',
  '/add_product'
];