import 'package:teste_guia_de_moteis/src/data/models/response_model.dart';

abstract class IMotelsRepository {
  Future<ResponseModel> getMotels();
}
