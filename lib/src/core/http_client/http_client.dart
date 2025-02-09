import 'http_client_interface.dart';
import 'package:http/http.dart' as http;

class HttpClient implements IHttpClientService {
  @override
  Future<http.Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await http.get(Uri.http(path));
    } catch (e) {
      rethrow;
    }
  }
}
