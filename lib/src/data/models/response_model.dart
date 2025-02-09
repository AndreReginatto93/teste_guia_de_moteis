import 'dart:convert';

import 'package:teste_guia_de_moteis/src/data/models/motel_model.dart';

class ResponseModel {
  final int pagina;
  final int qtdPorPagina;
  final int totalSuites;
  final int totalMoteis;
  final int raio;
  final double maxPaginas;
  final List<MotelModel> moteis;

  ResponseModel({
    required this.pagina,
    required this.qtdPorPagina,
    required this.totalSuites,
    required this.totalMoteis,
    required this.raio,
    required this.maxPaginas,
    required this.moteis,
  });

  factory ResponseModel.fromRawJson(String str) =>
      ResponseModel.fromJson(json.decode(str));

  static String toRawJson(Map<String, dynamic> response) =>
      json.encode(response);

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    pagina: json["pagina"],
    qtdPorPagina: json["qtdPorPagina"],
    totalSuites: json["totalSuites"],
    totalMoteis: json["totalMoteis"],
    raio: json["raio"],
    maxPaginas: json["maxPaginas"],
    moteis: List<MotelModel>.from(
      json["moteis"].map((x) => MotelModel.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "pagina": pagina,
    "qtdPorPagina": qtdPorPagina,
    "totalSuites": totalSuites,
    "totalMoteis": totalMoteis,
    "raio": raio,
    "maxPaginas": maxPaginas,
    "moteis": List<dynamic>.from(moteis.map((x) => x.toJson())),
  };
}
