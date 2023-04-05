// To parse this JSON data, do
//
//     final projectModel = projectModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'location_models.dart';

class ProjectModel {
  ProjectModel({
    this.id,
    this.title1,
    this.title2,
    this.staredPrice,
    this.payment,
    this.image,
    this.inSideImage,
    this.city,
    this.town,
    this.propertyType,
    this.deliveryDate,
    this.constructionYear,
    this.detailInformation,
    this.roomsAndPrice,
    this.date,
    this.propertyState,
    this.internalFeatures,
    this.externalFeatures,
    this.neighborhood,
    this.view,
    this.transportation,
    this.lastModified

  });

  City? city;
  Town? town;
  dynamic title1,title2,propertyType,propertyState,payment;
  String? id,deliveryDate,constructionYear,staredPrice;
  List<dynamic>? detailInformation,view,transportation,neighborhood,externalFeatures,internalFeatures,roomsAndPrice,inSideImage,image;
  Timestamp? date,lastModified;

  ProjectModel copyWith({
    String? id,
    dynamic title1,
    dynamic title2,
    String? staredPrice,
    dynamic payment,
    List<dynamic>? image,
    List<dynamic>? inSideImage,
    City? city,
    Town? town,
    dynamic propertyType,
    String? deliveryDate,
    String? constructionYear,
    List<dynamic>? detailInformation,
    List<dynamic>? roomsAndPrice,
    Timestamp? date,
    Timestamp? lastModified,

  }) =>
      ProjectModel(
        id: id ?? this.id,
        title1: title1 ?? this.title1,
        title2: title2 ?? this.title2,
        staredPrice: staredPrice ?? this.staredPrice,
        payment: payment ?? this.payment,
        image: image ?? this.image,
        inSideImage: inSideImage ?? this.inSideImage,
        city: city ?? this.city,
        town: town ?? this.town,
        propertyType: propertyType ?? this.propertyType,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        constructionYear: constructionYear ?? this.constructionYear,
        detailInformation: detailInformation ?? this.detailInformation,
        roomsAndPrice: roomsAndPrice ?? this.roomsAndPrice,
        date: date ?? this.date,
        propertyState: propertyState ?? this.propertyState,
        lastModified: lastModified ?? this.lastModified

      );

  factory ProjectModel.fromRawJson(String str) => ProjectModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toMap());

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
    id: json["id"],
    title1: json["title1"],
    title2: json["title2"],
    staredPrice: json["staredPrice"],
    payment: json["payment"],
    image: json["image"] != null ?   List<dynamic>.from(json["image"].map((x) => x)) : [],
    inSideImage:json["inSideImage"] != null ?  List<dynamic>.from(json["inSideImage"].map((x) => x)) : [],
    city: City.fromMap(json["city"]),
    town: Town.fromMap(json["town"]),
    propertyType: json["propertyType"],
    deliveryDate: json["deliveryDate"],
    propertyState: json['propertyState'],
    constructionYear: json["constructionYear"],
    detailInformation: json["detailInformation"] != null ? List<dynamic>.from(json["detailInformation"].map((x) => x)) : [],
    roomsAndPrice : json["roomsAndPrice"] != null ? List<dynamic>.from(json["roomsAndPrice"].map((x) => x)) : [], internalFeatures: json["internal_features"] == null ? [] : List<dynamic>.from(json["internal_features"].map((x) => x)),
    externalFeatures: json["external_features"] == null ? [] : List<dynamic>.from(json["external_features"].map((x) => x)),
    neighborhood: json["neighborhood"] == null ? [] : List<dynamic>.from(json["neighborhood"].map((x) => x)),
    transportation: json["transportation"] == null ? [] : List<dynamic>.from(json["transportation"].map((x) => x)),
    view: json["view"] == null ? [] : List<dynamic>.from(json["view"].map((x) => x)),
    date: json["date"] ?? Timestamp.fromDate(DateTime.now())
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title1": title1,
    "title2": title2,
    "staredPrice": staredPrice,
    "payment": payment,
    "image": List<dynamic>.from(image!.map((x) => x)),
    "inSideImage": List<dynamic>.from(inSideImage!.map((x) => x)),
    "city": city,
    "town": town,
    "propertyState":propertyState,
    "propertyType": propertyType,
    "deliveryDate": deliveryDate,
    "constructionYear": constructionYear,
    "detailInformation": List<dynamic>.from(detailInformation!.map((x) => x)),
    "roomsAndPrice": List<dynamic>.from(roomsAndPrice!.map((x) => x)),
    "internal_features": internalFeatures == null ? null : List<dynamic>.from(internalFeatures!.map((x) => x)),
    "external_features": externalFeatures == null ? null : List<dynamic>.from(externalFeatures!.map((x) => x)),
    "transportation": transportation == null ? null : List<dynamic>.from(transportation!.map((x) => x)),
    "view": view == null ? null : List<dynamic>.from(view!.map((x) => x)),
    "neighborhood": neighborhood == null ? null : List<dynamic>.from(neighborhood!.map((x) => x)),
    "date":date,
    "lastModified":lastModified
  };

}
