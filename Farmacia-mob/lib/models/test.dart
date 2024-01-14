// To parse this JSON data, do
//
//     final test = testFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Test testFromJson(String str) => Test.fromJson(json.decode(str));

String testToJson(Test data) => json.encode(data.toJson());

class Test {
  final List<Med> meds;

  Test({
    required this.meds,
  });

  factory Test.fromJson(Map<String, dynamic> json) => Test(
    meds: List<Med>.from(json["meds"].map((x) => Med.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meds": List<dynamic>.from(meds.map((x) => x.toJson())),
  };
}

class Med {
  final String medId;
  final String quantity;

  Med({
    required this.medId,
    required this.quantity,
  });

  factory Med.fromJson(Map<String, dynamic> json) => Med(
    medId: json["med_id"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "med_id": medId,
    "quantity": quantity,
  };
}
