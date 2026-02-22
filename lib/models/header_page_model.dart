// To parse this JSON data, do
//
//     final headerPageModel = headerPageModelFromJson(jsonString);

import 'dart:convert';

class HeaderPageModel {
  HeaderPageModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.title2,
    required this.type,
  });
  String id;
  String imageUrl;
  dynamic title;
  dynamic title2;
  String type;

  HeaderPageModel copyWith({
    String? id,
    String? imageUrl,
    dynamic title1,
    dynamic title2,
    String? type,
  }) => HeaderPageModel(
    id: id ?? this.id,
    imageUrl: imageUrl ?? this.imageUrl,
    title: title1 ?? title,
    title2: title1 ?? title2,
    type: type ?? this.type,
  );

  factory HeaderPageModel.fromRawJson(String str) =>
      HeaderPageModel.fromJson(json.decode(str));

  factory HeaderPageModel.fromJson(Map<String, dynamic>? json) =>
      HeaderPageModel(
        id: json!["id"] == null ? '' : json["id"],
        imageUrl: json["src"] == '' ? null : json["src"],
        type: json["type"] ?? '',
        title: json["title"] ?? '',
        title2: json["title2"] ?? '',
      );
}
