class MedModProfile {
  final String scientificName;
  final String commercialName;
  final String manufactureCompany;
  final String expirationDate;
  final int price;
  final int id;

  MedModProfile(
      {required this.scientificName,
      required this.commercialName,
      required this.manufactureCompany,
      required this.expirationDate,
      required this.price,
      required this.id});
  factory MedModProfile.fromJson(Map<String, dynamic> json) {
    return MedModProfile(
        scientificName: json['scientific_name'],
        commercialName: json['commercial_name'],
        manufactureCompany: json['manufacture_company'],
        expirationDate: json['Expiration_date'],
        price: json['price'],
        id: json['id']);
  }
}
