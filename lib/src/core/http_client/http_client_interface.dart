import 'package:http/http.dart' as http;

abstract class IHttpClientService {
  Future<http.Response> get(
    String path, {
    String? unencodedPath,
    Map<String, dynamic>? queryParameters,
  });
}
