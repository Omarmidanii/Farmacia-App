class MedMod {
  final String commercialName;
  final int price;
  final int id;
  final bool isfav;


  MedMod(
      {
      required this.commercialName,
      required this.price,
      required this.id,
        required this.isfav,
      });
  factory MedMod.fromJson(Map<String, dynamic> json) {
    return MedMod(

       commercialName: json['commercial_name'],
        price: json['price'],
        id: json['id'],
        isfav: json['is_favorite']
        );

  }
}
