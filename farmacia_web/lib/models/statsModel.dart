class statsModel {
  final int profits;
  final int quantityOfMedication;
  final int numberOfUsers;
  final int numberOfOrders;

  statsModel({
    required this.profits,
    required this.quantityOfMedication,
    required this.numberOfUsers,
    required this.numberOfOrders,
  });

  factory statsModel.fromJson(Map<String, dynamic> json) {
    return statsModel(
      profits: json['Profits'],
      quantityOfMedication: json['Quantity_of_medication'],
      numberOfUsers: json['Number_Of_Users'],
      numberOfOrders: json['Number_Of_Orders'],
    );
  }
}
