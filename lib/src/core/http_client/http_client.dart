// coverage:ignore-file
import 'http_client_interface.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as io;

class MyHttpOverrides extends io.HttpOverrides {
  @override
  io.HttpClient createHttpClient(io.SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (io.X509Certificate cert, String host, int port) => true;
  }
}

class HttpClient implements IHttpClientService {
  @override
  Future<http.Response> get(
    String path, {
    String? unencodedPath,
    Map<String, String>? headers,
  }) async {
    try {
      return await http.get(
        Uri.http(path, unencodedPath ?? ""),
        headers: headers,
      );
    } catch (e) {
      rethrow;
    }
  }
}
