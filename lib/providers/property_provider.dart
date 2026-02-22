import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/property_model.dart';
import '../services/firebase_collections_names.dart';
import '../services/firebase_methods.dart';

class PropertyProvider with ChangeNotifier {
  final List<PropertyModel> _allProperties = [];
  List<PropertyModel> _filteredProperties = [];
  bool _isLoading = false;

  List<PropertyModel> get properties => _filteredProperties;
  bool get isLoading => _isLoading;

  List<String> get tickerItems => _allProperties
      .take(10)
      .map(
        (p) =>
            '${p.getLocalized(p.title, 'en').toUpperCase()} — ${p.getLocalized(p.location, 'en').toUpperCase()} · ${p.currency}${p.price.toInt()}',
      )
      .toList();

  // Filter state
  double? maxPrice;
  String? selectedLocation;
  String? selectedCategory; // sale, rental, project

  PropertyProvider() {
    _initStreams();
  }

  void _initStreams() {
    _isLoading = true;

    // Combine multiple collections into one stream or listen separately
    // For simplicity, let's start with sales and projects as "Featured"
    FirebaseMethod.streams(co: FirebaseCollectionNames.SalesCollection).listen((
      snapshot,
    ) {
      _updateList(snapshot, 'sale');
    });

    FirebaseMethod.streams(
      co: FirebaseCollectionNames.ProjectsCollection,
    ).listen((snapshot) {
      _updateList(snapshot, 'project');
    });

    FirebaseMethod.streams(co: FirebaseCollectionNames.ResaleCollection).listen(
      (snapshot) {
        _updateList(snapshot, 'resale');
      },
    );
  }

  void _updateList(
    QuerySnapshot<Map<String, dynamic>> snapshot,
    String category,
  ) {
    // Remove old items from this category
    _allProperties.removeWhere((p) => p.category == category);

    // Add new items
    for (var doc in snapshot.docs) {
      final p = PropertyModel.fromFirestore(doc);

      // Filter out empty/dummy initialization documents
      if (p.getLocalized(p.title, 'en').isEmpty && p.price == 0) continue;

      _allProperties.add(p); // Use the full model from firestore
    }

    _allProperties.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    _applyFilters();
    _isLoading = false;
    notifyListeners();
  }

  void updateFilters({double? price, String? location, String? category}) {
    maxPrice = price;
    selectedLocation = location;
    selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    _filteredProperties = _allProperties.where((p) {
      bool priceMatch = maxPrice == null || p.price <= maxPrice!;
      bool locationMatch =
          selectedLocation == null ||
          p
              .getLocalized(p.location, 'en')
              .toLowerCase()
              .contains(selectedLocation!.toLowerCase());
      bool categoryMatch =
          selectedCategory == null || p.category == selectedCategory;

      return priceMatch && locationMatch && categoryMatch;
    }).toList();
  }
}
