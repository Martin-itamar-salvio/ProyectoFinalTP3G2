import 'dart:io';

import 'package:flutter/material.dart';

class Exit extends StatelessWidget {
  const Exit({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close),
      iconSize: 40,
      onPressed: () => exit(0)
    );
  }
}