class Fav_Model{
  final String name;
  final int id;
  final int price;
  Fav_Model({
    required this.name,
    required this.id,
    required this.price,
  });
  factory Fav_Model.fromJson(Map<String, dynamic> json) {
    return Fav_Model(
      name: json['name'],
      id: json['id'],
      price:json['price'],
    );
  }
}