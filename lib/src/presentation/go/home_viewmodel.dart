import 'package:flutter/foundation.dart';
import 'package:teste_guia_de_moteis/src/data/models/motel_model.dart';
import 'package:teste_guia_de_moteis/src/data/models/response_model.dart';
import 'package:teste_guia_de_moteis/src/domain/repositories/motels_repository.dart';

class HomeViewmodel with ChangeNotifier {
  final IMotelsRepository motelsRepository;

  HomeViewmodel(this.motelsRepository);

  /* ResponseModel */
  ResponseModel? _responseModel;
  ResponseModel? get responseModel => _responseModel;

  Future<void> getMotels() async {
    try {
      _responseModel = await motelsRepository.getMotels();
      notifyListeners();
      _applyFilters();
    } catch (e) {
      print(e);
    }
  }

  /* TabIndex */
  int tabIndex = 0;
  void changeTab(int index) {
    tabIndex = index;
    notifyListeners();
  }

  /* Filters */
  List<String> getFilters() {
    final filters = <String>{};
    _responseModel?.moteis.forEach((motel) {
      for (var suite in motel.suites) {
        for (var item in suite.categoriaItens) {
          filters.add(item.nome);
        }
      }
    });
    return filters.toList();
  }

  List<String> selectedFilters = [];

  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
    notifyListeners();
    _applyFilters();
  }

  bool isFilterSelected(String filter) {
    return selectedFilters.contains(filter);
  }

  /* FilteredMotels */
  List<MotelModel>? _filteredMotels;
  List<MotelModel>? get filteredMotels => _filteredMotels;
  void _applyFilters() {
    if (selectedFilters.isEmpty) {
      _filteredMotels = _responseModel?.moteis ?? [];
      return;
    }

    _filteredMotels =
        (_responseModel?.moteis
                    .map((motel) {
                      final filteredSuites =
                          motel.suites.where((suite) {
                            return selectedFilters.every((filter) {
                              return suite.categoriaItens.any((item) {
                                return item.nome == filter;
                              });
                            });
                          }).toList();

                      if (filteredSuites.isNotEmpty) {
                        return motel.copyWith(suites: filteredSuites);
                      }
                      return null;
                    })
                    .where((motel) => motel != null)
                    .toList() ??
                [])
            .cast<MotelModel>();
    notifyListeners();
  }

  String formatCurrency(double value) {
    return "R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}";
  }

  String formatDiscount(double valorTotal, double valor) {
    return "${((1 - (valorTotal / valor)) * 100).round()}% OFF";
  }
}
