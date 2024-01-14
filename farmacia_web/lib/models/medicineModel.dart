class medicineModel {
  final int id;
  final String scientificName;
  final String commercialName;
  final String manufactureCompany;
  final int availableQuantity;
  final String expirationDate;
  final double price;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final int classificationId;
  medicineModel({
    required this.id,
    required this.scientificName,
    required this.commercialName,
    required this.manufactureCompany,
    required this.availableQuantity,
    required this.expirationDate,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.classificationId,
  });

  factory medicineModel.fromJson(Map<String, dynamic> json) {
    return medicineModel(
      id: json['id'],
      scientificName: json['scientific_name'],
      commercialName: json['commercial_name'],
      manufactureCompany: json['manufacture_company'],
      availableQuantity: json['Available_quantity'],
      expirationDate: json['Expiration_date'],
      price: json['price'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      classificationId: json['classification_id'],
    );
  }

  @override
  String toString() {
    return '{$id, $scientificName, $commercialName, $manufactureCompany, $availableQuantity, $expirationDate, $price, $createdAt, $updatedAt, $deletedAt, $classificationId';
  }
}
class medMod {
  // final String scientificName;
  final String commercialName;
  //final String manufactureCompany;
  //final String expirationDate;
  final int price;
  final int id;

  medMod(
      {//required this.scientificName,
        required this.commercialName,
        //required this.manufactureCompany,
        //required this.expirationDate,
        required this.price,
        required this.id});
  factory medMod.fromJson(Map<String, dynamic> json) {
    return medMod(
      // scientificName: json['scientific_name'],
        commercialName: json['commercial_name'],
        //manufactureCompany: json['manufacture_company'],
        //expirationDate: json['Expiration_date'],
        price: json['price'],
        id: json['id']);
  }
}

class medSearMod {
  // final String scientificName;
  final String commercialName;
  //final String manufactureCompany;
  //final String expirationDate;
  final int price;
  final int id;

  medSearMod(
      {//required this.scientificName,
        required this.commercialName,
        //required this.manufactureCompany,
        //required this.expirationDate,
        required this.price,
        required this.id});
  factory medSearMod.fromJson(Map<String, dynamic> json) {
    return medSearMod(
      // scientificName: json['scientific_name'],
        commercialName: json['commercial_name'],
        //manufactureCompany: json['manufacture_company'],
        //expirationDate: json['Expiration_date'],
        price: json['price'],
        id: json['id']);
  }
}
