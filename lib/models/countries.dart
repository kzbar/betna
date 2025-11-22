import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Country {
  final String nameEn;
  final String nameAr;
  final String iso;
  final String phone;

  Country({
    required this.nameEn,
    required this.nameAr,
    required this.iso,
    required this.phone,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      nameEn: json['name_en'] as String,
      nameAr: json['name_ar'] as String,
      iso: json['iso'] as String,
      phone: json['phone'] as String,
    );
  }
}


class CountryRepository {
  Future<List<Country>> loadCountries() async {
    final jsonStr = await rootBundle.loadString('assets/countries.json');
    final List<dynamic> data = json.decode(jsonStr) as List<dynamic>;
    return data
        .map((e) => Country.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}