import 'package:teste_guia_de_moteis/src/data/models/data_model.dart';

abstract class MotelsRepository {
  Future<List<ResponseModel>> getMotels();
}
