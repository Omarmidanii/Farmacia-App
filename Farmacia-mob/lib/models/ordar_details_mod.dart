class OrdarDetMod {
  // ignore: non_constant_identifier_names
  final String medicine_name;
  final int quantity;

  // ignore: non_constant_identifier_names
  OrdarDetMod({required this.medicine_name, required this.quantity});

  factory OrdarDetMod.fromJson(Map<String, dynamic> json) {
    return OrdarDetMod(
        medicine_name: json['Medicine_Name'],
        quantity: json['Required_Quantity']);
  }
}
