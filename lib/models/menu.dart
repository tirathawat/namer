import 'package:flutter/material.dart';

class Menu {
  const Menu({
    required this.title,
    required this.icon,
    required this.page,
  });

  final String title;
  final IconData icon;
  final Widget page;
}
