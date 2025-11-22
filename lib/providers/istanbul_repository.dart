import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<Map<String, List<String>>> loadNeighborhoodsByDistrict() async {
  final raw =
  await rootBundle.loadString('assets/istanbul_neighborhoods.json');
  final List<dynamic> data = json.decode(raw) as List<dynamic>;

  final Map<String, List<String>> map = {};

  for (final item in data) {
    final obj = item as Map<String, dynamic>;
    final String district = obj['district'] as String;
    final List<String> neighborhoods = (obj['neighborhoods'] as List<dynamic>)
        .map((e) => e as String)
        .toList();

    map[district] = neighborhoods;
  }

  return map;
}
