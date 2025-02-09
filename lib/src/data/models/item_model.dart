import 'dart:convert';

class Item {
  final String nome;

  Item({required this.nome});

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(nome: json["nome"]);

  Map<String, dynamic> toJson() => {"nome": nome};
}
