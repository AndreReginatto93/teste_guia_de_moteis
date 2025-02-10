import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_guia_de_moteis/src/core/http_client/http_client_interface.dart';
import 'package:teste_guia_de_moteis/src/data/models/response_model.dart';
import 'package:teste_guia_de_moteis/src/data/repositories/motels_repository.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'response_mock.dart';

class MockHttpClientService extends Mock implements IHttpClientService {
  @override
  Future<http.Response> get(
    String path, {
    String? unencodedPath,
    Map<String, String>? headers,
  }) {
    return super.noSuchMethod(
      Invocation.method(
        #get,
        [path],
        {#unencodedPath: unencodedPath, #headers: headers},
      ),
      returnValue: Future.value(
        http.Response(jsonEncode(ResponseMockTest.mock), 200),
      ),
      returnValueForMissingStub: Future.value(
        http.Response(jsonEncode(ResponseMockTest.mock), 200),
      ),
    );
  }
}

void main() {
  late MotelsRepository repository;
  late MockHttpClientService mockHttpClientService;

  setUp(() {
    mockHttpClientService = MockHttpClientService();
    repository = MotelsRepository(mockHttpClientService);
  });

  test('should return a ResponseModel when the call is successful', () async {
    when(mockHttpClientService.get("any")).thenAnswer(
      (_) async =>
          Future.value(http.Response(json.encode(ResponseMockTest.mock), 200)),
    );

    final result = await repository.getMotels();

    expect(result, isA<ResponseModel>());
    expect(result.moteis.length, 1);
    expect(result.totalMoteis, 1);
    expect(result.maxPaginas, 1.0);
    expect(result.pagina, 1);
    expect(result.totalSuites, 0);
    expect(result.moteis[0].suites.length, 9);
  });
}
