import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_guia_de_moteis/src/core/http_client/http_client.dart';

import 'app.dart';
import 'src/core/dependencies_injection/dependencies.dart';

void main() async {
  // HandshakeException: Handshake error in client
  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiProvider(providers: providers, child: const MainApp(route: "/")));
}
