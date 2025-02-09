import 'dart:convert';

class CategoriaItem {
  final String nome;
  final String icone;

  CategoriaItem({required this.nome, required this.icone});

  factory CategoriaItem.fromRawJson(String str) =>
      CategoriaItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoriaItem.fromJson(Map<String, dynamic> json) =>
      CategoriaItem(nome: json["nome"], icone: json["icone"]);

  Map<String, dynamic> toJson() => {"nome": nome, "icone": icone};
}
