class ordersModel {
  final int id;
  final String creationDate;
  final String customerName;
  String status;
  final double totalPrice;
  String paymentStatus;
  //bool showButton = false;
  //final String updatedDate;
  // ignore: use_key_in_widget_constructors
   ordersModel({
     required this.id,
     required this.creationDate,
     required this.customerName,
     required this.status,
     required this.totalPrice,
     required this.paymentStatus,
     //required this.updatedDate,
   });
  factory ordersModel.fromJson(Map<String, dynamic> json) {
    return ordersModel(
      id: json['Order_Id'],
      creationDate: json['Creation_Date'],
      customerName: json['name'],
      status: json['State'],
      totalPrice: json['Total_Price'],
      paymentStatus: json['Payment_State'],
      //updatedDate: json['updated_date'],
    );
  }
}

class Order {
  final String name;
  final int orderId;
  final String state;
  final String paymentState;
  final String creationDate;
  final int totalPrice;
  final List<Medicine> medicines;

  Order({
    required this.name,
    required this.orderId,
    required this.state,
    required this.paymentState,
    required this.creationDate,
    required this.totalPrice,
    required this.medicines,
  });

  factory Order.fromJson(List<dynamic> json) {
    Map<String, dynamic> orderDetails = json[0];
    List<dynamic> medicinesJson = json[1];

    List<Medicine> medicinesList = medicinesJson.map((e) => Medicine.fromJson(e)).toList();

    return Order(
      name: orderDetails['name'],
      orderId: orderDetails['Order_Id'],
      state: orderDetails['State'],
      paymentState: orderDetails['Payment_State'],
      creationDate: orderDetails['Creation_Date'],
      totalPrice: orderDetails['Total_Price'],
      medicines: medicinesList,
    );
  }
}
class Medicine {
  final String medicineName;
  final int requiredQuantity;

  Medicine({
    required this.medicineName,
    required this.requiredQuantity,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      medicineName: json['Medicine_Name'],
      requiredQuantity: json['Required_Quantity'],
    );
  }
}