import 'dart:convert';

class Desconto {
  final double desconto;

  Desconto({required this.desconto});

  factory Desconto.fromRawJson(String str) =>
      Desconto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Desconto.fromJson(Map<String, dynamic> json) =>
      Desconto(desconto: json["desconto"]?.toDouble());

  Map<String, dynamic> toJson() => {"desconto": desconto};
}
