import 'package:teste_guia_de_moteis/src/core/http_client/http_client_interface.dart';
import 'package:teste_guia_de_moteis/src/data/models/response_model.dart';
import 'package:teste_guia_de_moteis/src/domain/repositories/motels_repository.dart';
import 'dart:convert';
import 'dart:typed_data';

class MotelsRepository implements IMotelsRepository {
  final IHttpClientService _httpClientService;

  MotelsRepository(this._httpClientService);

  @override
  Future<ResponseModel> getMotels() async {
    final response = await _httpClientService.get(
      "jsonkeeper.com",
      unencodedPath: "/b/1IXK",
    );
    if (response.statusCode == 200) {
      final Uint8List bytes = response.bodyBytes;
      final String decodedBody = utf8.decode(bytes, allowMalformed: true);
      final Map<String, dynamic> data = json.decode(decodedBody);
      return ResponseModel.fromJson(data["data"]);
    } else {
      throw Exception('Failed to load motels');
    }
  }
}
