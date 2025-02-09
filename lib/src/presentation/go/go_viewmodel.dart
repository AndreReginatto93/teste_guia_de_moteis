import 'package:flutter/foundation.dart';
import 'package:teste_guia_de_moteis/src/data/models/response_model.dart';
import 'package:teste_guia_de_moteis/src/domain/repositories/motels_repository.dart';

class GoViewmodel with ChangeNotifier {
  final IMotelsRepository motelsRepository;

  GoViewmodel(this.motelsRepository);

  ResponseModel? _responseModel;
  ResponseModel? get responseModel => _responseModel;

  Future<void> getMotels() async {
    try {
      _responseModel = await motelsRepository.getMotels();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
