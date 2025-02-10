import 'package:teste_guia_de_moteis/src/data/models/suite_model.dart';

class MotelModel {
  final String fantasia;
  final String logo;
  final String bairro;
  final double distancia;
  final int qtdFavoritos;
  final List<SuiteModel> suites;
  final int qtdAvaliacoes;
  final double media;

  MotelModel({
    required this.fantasia,
    required this.logo,
    required this.bairro,
    required this.distancia,
    required this.qtdFavoritos,
    required this.suites,
    required this.qtdAvaliacoes,
    required this.media,
  });

  MotelModel copyWith({
    String? fantasia,
    String? logo,
    String? bairro,
    double? distancia,
    int? qtdFavoritos,
    List<SuiteModel>? suites,
    int? qtdAvaliacoes,
    double? media,
  }) => MotelModel(
    fantasia: fantasia ?? this.fantasia,
    logo: logo ?? this.logo,
    bairro: bairro ?? this.bairro,
    distancia: distancia ?? this.distancia,
    qtdFavoritos: qtdFavoritos ?? this.qtdFavoritos,
    suites: suites ?? this.suites,
    qtdAvaliacoes: qtdAvaliacoes ?? this.qtdAvaliacoes,
    media: media ?? this.media,
  );

  factory MotelModel.fromJson(Map<String, dynamic> json) => MotelModel(
    fantasia: json["fantasia"],
    logo: json["logo"],
    bairro: json["bairro"],
    distancia: json["distancia"]?.toDouble(),
    qtdFavoritos: json["qtdFavoritos"],
    suites: List<SuiteModel>.from(
      json["suites"].map((x) => SuiteModel.fromJson(x)),
    ),
    qtdAvaliacoes: json["qtdAvaliacoes"],
    media: json["media"]?.toDouble(),
  );
}
