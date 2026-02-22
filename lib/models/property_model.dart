import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyModel {
  final String id;
  final Map<String, String> title;
  final Map<String, String> location;
  final double price;
  final String currency;
  final Map<String, String> tag;
  final String imageUrl;
  final List<String> images;
  final String category; // sale, rental, project, resale
  final DateTime createdAt;
  final bool isSold;
  final Map<String, String> description;
  final String videoUrl;

  String getLocalized(Map<String, String> map, String langCode) {
    return map[langCode] ??
        map['en'] ??
        map['tr'] ??
        map['ar'] ??
        (map.isNotEmpty ? map.values.first : '');
  }

  // New Specs for Resale & Details
  final Map<String, String> rooms;
  final double area;
  final Map<String, String> floor;
  final Map<String, String> age;

  // Project Specifics
  final Map<String, String> developer;
  final Map<String, String> status;
  final Map<String, String> deliveryDate;
  final bool isInstallmentAvailable;
  final List<String> amenities;

  PropertyModel({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    this.currency = 'USD',
    required this.tag,
    required this.imageUrl,
    this.images = const [],
    required this.category,
    required this.createdAt,
    this.isSold = false,
    this.rooms = const {},
    this.area = 0,
    this.floor = const {},
    this.age = const {},
    this.developer = const {},
    this.status = const {},
    this.deliveryDate = const {},
    this.isInstallmentAvailable = false,
    this.amenities = const [],
    this.description = const {},
    this.videoUrl = '',
  });

  factory PropertyModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    Map<String, String> extractMap(dynamic field) {
      if (field is Map) {
        return Map<String, String>.from(
          field.map((k, v) => MapEntry(k.toString(), v.toString())),
        );
      }
      if (field is String) {
        return {'en': field, 'tr': field, 'ar': field};
      }
      return {};
    }

    return PropertyModel(
      id: doc.id,
      title: extractMap(data['title']),
      location: extractMap(data['location']),
      price: (data['price'] ?? 0).toDouble(),
      currency: data['currency'] ?? 'USD',
      tag: extractMap(data['tag']),
      imageUrl: data['imageUrl'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      category: data['category'] ?? 'sale',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isSold: data['isSold'] ?? false,
      rooms: extractMap(data['rooms']),
      area: (data['area'] ?? 0).toDouble(),
      floor: extractMap(data['floor']),
      age: extractMap(data['age']),
      developer: extractMap(data['developer']),
      status: extractMap(data['status']),
      deliveryDate: extractMap(data['deliveryDate']),
      isInstallmentAvailable: data['isInstallmentAvailable'] ?? false,
      amenities: List<String>.from(data['amenities'] ?? []),
      description: extractMap(data['description']),
      videoUrl: data['videoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'location': location,
      'price': price,
      'currency': currency,
      'tag': tag,
      'imageUrl': imageUrl,
      'images': images,
      'category': category,
      'createdAt': Timestamp.fromDate(createdAt),
      'isSold': isSold,
      'rooms': rooms,
      'area': area,
      'floor': floor,
      'age': age,
      'developer': developer,
      'status': status,
      'deliveryDate': deliveryDate,
      'isInstallmentAvailable': isInstallmentAvailable,
      'amenities': amenities,
      'description': description,
      'videoUrl': videoUrl,
    };
  }
}
