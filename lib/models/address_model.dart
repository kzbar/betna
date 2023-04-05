// To parse this JSON data, do
//
//     final adress = adressFromMap(jsonString);

import 'dart:convert';

import 'package:betna/models/location_models.dart';

class Address {
  Address({
    this.city,
    this.town,
    this.neighborhoods,
    this.street,
    this.buildNo,
    this.apartmentNo,
  });

  City? city;
  Town? town;
  Neighborhood? neighborhoods;
  String? street;
  String? buildNo;
  String? apartmentNo;

  Address copyWith({
    String? city,
    String? town,
    String? neighborhoods,
    String? zipCode,
    String? street,
    String? buildNo,
    String? apartmentNo,
  }) =>
      Address(
        city: city as City? ?? this.city,
        town: town as Town? ?? this.town,
        neighborhoods: neighborhoods as Neighborhood? ?? this.neighborhoods,
        street: street ?? this.street,
        buildNo: buildNo ?? this.buildNo,
        apartmentNo: apartmentNo ?? this.apartmentNo,
      );

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    city: City.fromMap(json['city']),
    town: Town.fromMap(json['town']),
    neighborhoods: Neighborhood.fromMap(json['neighborhoods']),
    street: json["street"],
    buildNo: json["build_no"],
    apartmentNo: json["apartment_no"],
  );

  Map<String, dynamic> toMap() => {
    "city": city!.toMap(),
    "town": town!.toMap(),
    "neighborhoods": neighborhoods!.toMap(),
    "street": street,
    "build_no": buildNo,
    "apartment_no": apartmentNo,
  };
}
