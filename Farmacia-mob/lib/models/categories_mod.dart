class CategoriesMod {
  final int id;
  final String name;
  
  CategoriesMod({
   required this.id,
    required this.name,
  });
  factory CategoriesMod.fromJson(Map<String, dynamic> json) {
    return CategoriesMod(
      id: json['id'],
      name: json['name'],

    );
  }
}
