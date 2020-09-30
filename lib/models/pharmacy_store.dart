// To parse this JSON data, do
//
//     final pharmacyStores = pharmacyStoresFromJson(jsonString);

import 'dart:convert';

PharmacyStores pharmacyStoresFromJson(String str) => PharmacyStores.fromJson(json.decode(str));

String pharmacyStoresToJson(PharmacyStores data) => json.encode(data.toJson());

class PharmacyStores {
  PharmacyStores({
    this.status,
    this.message,
    this.pharmacy,
  });

  bool status;
  String message;
  List<Pharmacy> pharmacy;

  factory PharmacyStores.fromJson(Map<String, dynamic> json) => PharmacyStores(
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
  Pharmacy({
    this.id,
    this.name,
    this.contactPerson,
    this.phone,
    this.fax,
    this.city,
    this.state,
    this.address,
    this.email,
    this.zipcode,
  });

  int id;
  String name;
  String contactPerson;
  String phone;
  String fax;
  String city;
  String state;
  String address;
  String email;
  String zipcode;

  factory Pharmacy.fromJson(Map<String, dynamic> json) => Pharmacy(
    id: json["id"],
    name: json["name"],
    contactPerson: json["contact_person"],
    phone: json["phone"],
    fax: json["fax"],
    city: json["city"],
    state: json["state"],
    address: json["address"],
    email: json["email"],
    zipcode: json["zipcode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "contact_person": contactPerson,
    "phone": phone,
    "fax": fax,
    "city": city,
    "state": state,
    "address": address,
    "email": email,
    "zipcode": zipcode,
  };
}
