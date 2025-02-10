class Desconto {
  final double desconto;

  Desconto({required this.desconto});

  factory Desconto.fromJson(Map<String, dynamic> json) =>
      Desconto(desconto: json["desconto"]?.toDouble());
}
