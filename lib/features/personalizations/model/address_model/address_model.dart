import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
   String? id;
   final String name, phoneNumber, street, city, state, postalCode, country;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.country,
    required this.postalCode,
    required this.state,
    this.dateTime,
    this.selectedAddress = true,
  });

  static AddressModel empty() => AddressModel(
        name: "",
        phoneNumber: "",
        street: "",
        city: "",
        country: "",
        postalCode: "",
        state: "",
      );

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
        id: json["Id"] as String,
        name: json["Name"],
        phoneNumber: json["PhoneNumber"],
        street: json["Street"],
        city: json["City"],
        country: json["Country"],
        postalCode: json["PostalCode"],
        state: json["State"],
        selectedAddress: json["SelectedAddress"]);
  }
  factory AddressModel.fromDocument(DocumentSnapshot json) {
    final jsons = json.data() as Map<String, dynamic>;
    return AddressModel(
        id: json.id,
        name: jsons["Name"],
        phoneNumber: jsons["PhoneNumber"],
        street: jsons["Street"],
        city: jsons["City"],
        country: jsons["Country"],
        postalCode: jsons["PostalCode"],
        state: jsons["State"],
        selectedAddress: jsons["SelectedAddress"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "Name": name,
      "PhoneNumber": phoneNumber,
      "Street": street,
      "City": city,
      "Country": country,
      "PostalCode": postalCode,
      "State": state,
      "SelectedAddress": selectedAddress,
      "Time": DateTime.now()
    };
  }
}
