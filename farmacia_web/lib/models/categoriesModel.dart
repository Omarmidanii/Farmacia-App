class categoriesModel {
  final int id;
  final String name;

  categoriesModel({
    required this.id,
    required this.name,
  });
  factory categoriesModel.fromJson(dynamic json) {
    return categoriesModel(id: json['id'] as int, name: json['name'] as String);
  }

  @override
  String toString(){
    return '{$id, $name}';
  }
}
