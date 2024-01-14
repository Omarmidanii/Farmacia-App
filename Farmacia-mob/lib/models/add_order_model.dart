class add_order_Mod {
  final int id;
  final int Quantity;


  add_order_Mod(
      {
      required this.id,
     required this.Quantity,
  });
  Map<String, dynamic> toJson() =>{
    'med_id':id,
    'quantity':Quantity.toString(),
  };
  }
  //this model the recive my data from front which it is (each medicin and his quantity )
  //and send it to backend as a json file usinfg then method tojson tom parse me dato to json type

