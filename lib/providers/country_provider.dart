import 'package:flutter/material.dart';

import '../models/countries.dart';


class CountryProvider extends ChangeNotifier {


  CountryProvider();

  List<Country> _countries = [];
  Country? _selectedCountry;
  bool _isLoading = false;
  String? _error;

  List<Country> get countries => _countries;
  Country? get selectedCountry => _selectedCountry;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadCountries() async {
    if (_countries.isNotEmpty) return; // لا تعيد التحميل لو محمّل قبل

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _countries = await CountryRepository().loadCountries();

      // اختيار افتراضي (مثلاً تركيا)
      _selectedCountry = _countries.firstWhere(
            (c) => c.iso == 'TR',
        orElse: () => _countries.first,
      );
    } catch (e) {
      _error = 'Failed to load countries: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectCountry(Country country) {
    _selectedCountry = country;
    notifyListeners();
  }

  /// يرجع كود الهاتف للدولة الحالية مثل "+90"
  String get selectedPhoneCode => _selectedCountry?.phone ?? '';

  /// يعيد الدولة عن طريق الـ iso لو احتجتها
  Country? findByIso(String iso) {
    try {
      return _countries.firstWhere((c) => c.iso == iso);
    } catch (_) {
      return null;
    }
  }
}
