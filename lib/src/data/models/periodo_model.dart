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

  factory Periodo.fromJson(Map<String, dynamic> json) => Periodo(
    tempoFormatado: json["tempoFormatado"],
    tempo: json["tempo"],
    valor: json["valor"]?.toDouble(),
    valorTotal: json["valorTotal"]?.toDouble(),
    temCortesia: json["temCortesia"],
    desconto:
        json["desconto"] == null ? null : Desconto.fromJson(json["desconto"]),
  );
}
