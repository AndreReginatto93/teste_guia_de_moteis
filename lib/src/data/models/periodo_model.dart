import 'dart:convert';

import 'package:teste_guia_de_moteis/src/data/models/desconto_model.dart';

class Periodo {
  final String tempoFormatado;
  final String tempo;
  final double valor;
  final double valorTotal;
  final bool temCortesia;
  final Desconto? desconto;

  Periodo({
    required this.tempoFormatado,
    required this.tempo,
    required this.valor,
    required this.valorTotal,
    required this.temCortesia,
    required this.desconto,
  });

  factory Periodo.fromRawJson(String str) => Periodo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Periodo.fromJson(Map<String, dynamic> json) => Periodo(
    tempoFormatado: json["tempoFormatado"],
    tempo: json["tempo"],
    valor: json["valor"]?.toDouble(),
    valorTotal: json["valorTotal"]?.toDouble(),
    temCortesia: json["temCortesia"],
    desconto:
        json["desconto"] == null ? null : Desconto.fromJson(json["desconto"]),
  );

  Map<String, dynamic> toJson() => {
    "tempoFormatado": tempoFormatado,
    "tempo": tempo,
    "valor": valor,
    "valorTotal": valorTotal,
    "temCortesia": temCortesia,
    "desconto": desconto?.toJson(),
  };
}
