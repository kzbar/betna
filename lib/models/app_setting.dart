// To parse this JSON data, do
//
//     final projectModel = projectModelFromJson(jsonString);

import 'dart:convert';

import 'package:betna/models/company_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'location_models.dart';

class AppSetting {
  AppSetting({this.profile});

  CompanyProfile? profile;

  factory AppSetting.fromRawJson(String str) => AppSetting.fromJson(json.decode(str));

  factory AppSetting.fromJson(Map<String, dynamic> json) => AppSetting();

}
