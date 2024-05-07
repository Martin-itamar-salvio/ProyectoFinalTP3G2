import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String link;
  final String role;
  final bool params;

  MenuItem({required this.title, required this.subtitle, required this.icon, required this.link, required this.role, required this.params});
}
