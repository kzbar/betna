

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'enumerators.dart';

class MainProvider with ChangeNotifier {
  String kTurkish = 'Turkish';
  String kEnglish = 'English';
  String kArabic = 'العربية';
  Lang? currentLang;
  DisplayedPage? currentPage = DisplayedPage.HOME;
  Currency? currency;
  Map? currencyMap;
  Map? currencyMapUSD;
  TextDirection textDecoration = TextDirection.ltr;
  String kLang = 'en';

  MainProvider.init() {
    if (kDebugMode) {
      print('AppProvider inti');
    }
    currentPage = DisplayedPage.HOME;
    currency = Currency.TRY;
    changeCurrentLang(Lang.EN);
    notifyListeners();
  }
  changeCurrentLang(Lang? newPage) {
    currentLang = newPage;
    switch (newPage) {
      case Lang.AR:
        textDecoration = TextDirection.rtl;
        kLang = 'ar';
        break;
      case Lang.EN:
        textDecoration = TextDirection.ltr;
        kLang = 'en';

        break;
      case Lang.TR:
        textDecoration = TextDirection.ltr;
        kLang = 'tr';
        break;
      default:
        break;

    }
    var locale = Locale(kLang);
    Get.updateLocale(locale);
    notifyListeners();
    if (kDebugMode) {
      print(currentLang);
    }
  }

  changeCurrency(Currency? _currency, Map map) async {
    currency = _currency;
    currencyMap = map;
    notifyListeners();
  }

}