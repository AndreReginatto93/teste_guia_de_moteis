import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'src/core/dependencies_injection/dependencies.dart';

void main() async {
  runApp(MultiProvider(providers: providers, child: const MainApp(route: "/")));
}
