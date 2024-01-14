class all_med_model{
  final String name;
  final int id;
  all_med_model({
    required this.name,
    required this.id,
  });

  factory all_med_model.fromJson(Map<String, dynamic> json) {
    return all_med_model(
      name: json['commercial_name'],
      id: json['id'],
    );
  }
  }
//here I define a model to get all medicins in all categiogries by method it name showall