
import 'dart:convert';


import 'package:cloud_firestore/cloud_firestore.dart';

class SaleAdModel {
  SaleAdModel({
    this.adId,
    this.date,
    this.title,
    this.lastModified,
    this.price,
    this.area,
    this.netArea,
    this.explanation,
    this.insideSite,
    this.ageBuilding,
    this.balcony,
    this.state,
    this.room,
    this.floor,
    this.images,
    this.address,
    this.available,
    this.urgent,
    this.floors,
    this.bathrooms,
    this.typesHeating,
    this.propertyCase,
    this.internalFeatures,
    this.externalFeatures,
    this.neighborhood,
    this.view,
    this.transportation,
    this.affordableHomes,
    this.luxuryHomes

  });

  String? adId;
  Timestamp? date;
  Timestamp? lastModified;
  String? price;
  dynamic title;
  String? area;
  String? netArea;
  dynamic explanation;
  String? insideSite;
  String? ageBuilding;
  String? balcony;
  dynamic state;
  String? room;
  String? floor;
  String? floors;
  String? bathrooms;
  dynamic typesHeating;
  String? propertyCase;
  String? affordableHomes;
  String? luxuryHomes;

  bool? available;
  bool? urgent;
  List<dynamic>? images = [];
  List<dynamic>? internalFeatures;
  List<dynamic>? externalFeatures;
  List<dynamic>? neighborhood;
  List<dynamic>? transportation;
  List<dynamic>? view;
  Map<String,dynamic>? address;

  factory SaleAdModel.fromJson(String str) => SaleAdModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SaleAdModel.fromMap(Map<String, dynamic> json) => SaleAdModel(
    adId: json["ad_id"],
    date: json["date"],
    title: json["title"],
    lastModified: json["lastModified"],
    price: json["price"],
    area: json["area"],
    netArea: json["net_area"],
    explanation: json["explanation"],
    insideSite: json["inside_site"],
    ageBuilding: json["age_building"],
    balcony: json["balcony"],
    state: json["state"],
    typesHeating: json["types_heating"],
    bathrooms: json["bathrooms"],
    floors: json["floors"],
    propertyCase: json["property_case"],
    room: json["room"],
    floor: json["floor"],
    available: json["available"] ?? true,
    urgent: json["urgent"] ?? true,
    address: json["address"],
    images: json["images"] == null ? [] : List<dynamic>.from(json["images"].map((x) => x)),
    internalFeatures: json["internal_features"] == null ? [] : List<dynamic>.from(json["internal_features"].map((x) => x)),
    externalFeatures: json["external_features"] == null ? [] : List<dynamic>.from(json["external_features"].map((x) => x)),
    neighborhood: json["neighborhood"] == null ? [] : List<dynamic>.from(json["neighborhood"].map((x) => x)),
    transportation: json["transportation"] == null ? [] : List<dynamic>.from(json["transportation"].map((x) => x)),
    view: json["view"] == null ? [] : List<dynamic>.from(json["view"].map((x) => x)),
  affordableHomes: json['affordableHomes'],
  luxuryHomes: json['luxuryHomes']

  );

  Map<String, dynamic> toMap() => {
    "ad_id": adId,
    "date": date,
    "title": title,
    "lastModified": lastModified,
    "price": price,
    "area": area,
    "net_area": netArea,
    "explanation": explanation,
    "inside_site": insideSite ?? false,
    "age_building": ageBuilding,
    "balcony": balcony ?? false,
    "state": state,
    "room": room,
    "floor": floor,
    "floors": floors,
    "available": available ?? true,
    "urgent": urgent ?? true,
    "images": images == null ? null : List<dynamic>.from(images!.map((x) => x)),
    "address": address,
    "types_heating": typesHeating,
    "property_case": propertyCase,
    "bathrooms": bathrooms,
    "internal_features": internalFeatures == null ? null : List<dynamic>.from(internalFeatures!.map((x) => x)),
    "external_features": externalFeatures == null ? null : List<dynamic>.from(externalFeatures!.map((x) => x)),
    "transportation": transportation == null ? null : List<dynamic>.from(transportation!.map((x) => x)),
    "view": view == null ? null : List<dynamic>.from(view!.map((x) => x)),
    "neighborhood": neighborhood == null ? null : List<dynamic>.from(neighborhood!.map((x) => x)),
    'affordableHomes':affordableHomes ?? false,
    'luxuryHomes':luxuryHomes ?? false
  };

}
