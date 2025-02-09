import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/core/themes/theme.dart';

class MainApp extends StatelessWidget {
  final String route;
  const MainApp({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
