import 'package:teste_guia_de_moteis/src/core/http_client/http_client_interface.dart';
import 'package:teste_guia_de_moteis/src/data/models/response_model.dart';
import 'package:teste_guia_de_moteis/src/domain/repositories/motels_repository.dart';
import 'dart:convert';

class MotelsRepository implements IMotelsRepository {
  final IHttpClientService _httpClientService;

  MotelsRepository(this._httpClientService);

  final String _url = "jsonkeeper.com/b/1IXK";

  @override
  Future<ResponseModel> getMotels() async {
    final response = await _httpClientService.get(_url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ResponseModel.fromJson(data["data"]);
    } else {
      throw Exception('Failed to load motels');
    }
  }
}
