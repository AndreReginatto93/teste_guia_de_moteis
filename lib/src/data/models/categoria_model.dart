class CategoriaItem {
  final String nome;
  final String icone;

  CategoriaItem({required this.nome, required this.icone});

  factory CategoriaItem.fromJson(Map<String, dynamic> json) =>
      CategoriaItem(nome: json["nome"], icone: json["icone"]);
}
