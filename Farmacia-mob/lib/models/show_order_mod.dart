class ShowOrderMod {
  final int orderNumber;
  final String status;

  // ignore: use_key_in_widget_constructors
  const ShowOrderMod({required this.orderNumber, required this.status});
  factory ShowOrderMod.fromJson(Map<String, dynamic> json) { 
    return ShowOrderMod( 
      orderNumber:json['Order_Id'],
      status: json['State']
      );
   
  }
}
