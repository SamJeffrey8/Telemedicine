// To parse this JSON data, do
//
//     final drugsList = drugsListFromJson(jsonString);

import 'dart:convert';

DrugsList drugsListFromJson(String str) => DrugsList.fromJson(json.decode(str));

String drugsListToJson(DrugsList data) => json.encode(data.toJson());

class DrugsList {


  bool status;
  String message;
  List<Pharmacy> pharmacy;
  DrugsList({
    this.status,
    this.message,
    this.pharmacy,
  });

  factory DrugsList.fromJson(Map<String, dynamic> json) => DrugsList(
    status: json["status"],
    message: json["message"],
    pharmacy: List<Pharmacy>.from(json["Pharmacy"].map((x) => Pharmacy.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "Pharmacy": List<dynamic>.from(pharmacy.map((x) => x.toJson())),
  };
}

class Pharmacy {


  int id;
  int sNo;
  String ndc;
  String drug;
  String bgLink;
  String pharmacyClass;
  int qty;

  Pharmacy({
    this.id,
    this.sNo,
    this.ndc,
    this.drug,
    this.bgLink,
    this.pharmacyClass,
    this.qty,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) => Pharmacy(
    id: json["id"],
    sNo: json["SNo"],
    ndc: json["NDC"],
    drug: json["Drug"],
    bgLink:json["BGLink"],
    pharmacyClass:json["Class"],
    qty: json["Qty"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "SNo": sNo,
    "NDC": ndc,
    "Drug": drug,
    "BGLink": bgLink,
    "Class": pharmacyClass,
    "Qty": qty,
  };
}

