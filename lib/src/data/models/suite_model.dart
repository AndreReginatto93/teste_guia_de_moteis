import 'dart:convert';

import 'package:teste_guia_de_moteis/src/data/models/categoria_model.dart';
import 'package:teste_guia_de_moteis/src/data/models/item_model.dart';
import 'package:teste_guia_de_moteis/src/data/models/periodo_model.dart';

class SuiteModel {
  final String nome;
  final int qtd;
  final bool exibirQtdDisponiveis;
  final List<String> fotos;
  final List<Item> itens;
  final List<CategoriaItem> categoriaItens;
  final List<Periodo> periodos;

  SuiteModel({
    required this.nome,
    required this.qtd,
    required this.exibirQtdDisponiveis,
    required this.fotos,
    required this.itens,
    required this.categoriaItens,
    required this.periodos,
  });

  factory SuiteModel.fromRawJson(String str) =>
      SuiteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SuiteModel.fromJson(Map<String, dynamic> json) => SuiteModel(
    nome: json["nome"],
    qtd: json["qtd"],
    exibirQtdDisponiveis: json["exibirQtdDisponiveis"],
    fotos: List<String>.from(json["fotos"].map((x) => x)),
    itens: List<Item>.from(json["itens"].map((x) => Item.fromJson(x))),
    categoriaItens: List<CategoriaItem>.from(
      json["categoriaItens"].map((x) => CategoriaItem.fromJson(x)),
    ),
    periodos: List<Periodo>.from(
      json["periodos"].map((x) => Periodo.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "nome": nome,
    "qtd": qtd,
    "exibirQtdDisponiveis": exibirQtdDisponiveis,
    "fotos": List<dynamic>.from(fotos.map((x) => x)),
    "itens": List<dynamic>.from(itens.map((x) => x.toJson())),
    "categoriaItens": List<CategoriaItem>.from(
      categoriaItens.map((x) => x.toJson()),
    ),
    "periodos": List<dynamic>.from(periodos.map((x) => x.toJson())),
  };
}
