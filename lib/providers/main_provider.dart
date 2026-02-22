import 'package:betna/services/firebase_collections_names.dart';
import 'package:betna/services/firebase_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../setup/enumerators.dart';

class MainProvider with ChangeNotifier {
  String kTurkish = 'Turkish';
  String kEnglish = 'English';
  String kArabic = 'العربية';
  Lang? currentLang;
  DisplayedPage? currentPage = DisplayedPage.HOME;

  ///
  Currency? currency;
  Map? currencyMap;
  Map? currencyMapUSD;
  List<QueryDocumentSnapshot> currencyList = [];

  ///
  TextDirection textDecoration = TextDirection.ltr;
  String kLang = 'tr';

  /// fetch data from firebase
  FetchDataState fetchDataState = FetchDataState.none;
  MainProvider.init() {
    if (kDebugMode) {
      print('AppProvider inti');
    }

    currentPage = DisplayedPage.HOME;
    currency = Currency.TRY;
    // Language is set by the router on first load based on device locale
    notifyListeners();
    //getDataList();
    //getCurrent();
  }

  void changeCurrentLang(Lang? newPage) {
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

  Future<void> getCurrent() async {
    DocumentSnapshot snapshot = await FirebaseMethod.get(
      co: FirebaseCollectionNames.CurrencyCollection,
      doc: 'USD',
    );
    QuerySnapshot currency = await FirebaseMethod.gets(
      co: FirebaseCollectionNames.CurrencyCollection,
    );
    currencyMapUSD = snapshot.data() as Map<dynamic, dynamic>?;
    currencyList = currency.docs;
    if (kDebugMode) {
      print(currencyMap);
      print(currencyMapUSD);
    }
    notifyListeners();
  }

  void changeCurrency(Currency? newCurrency, Map map) async {
    currency = newCurrency;
    currencyMap = map;
    notifyListeners();
  }
}

enum FetchDataState { done, wait, error, none }

class ListNotifier<T> {
  List<T>? list = [];
  Future<FetchDataState>? fetchDataState;

  QuerySnapshot? querySnapshot;

  ListNotifier({required Future<FetchDataState> this.fetchDataState});

  ListNotifier.init(
    this.list,
    Future<FetchDataState> this.fetchDataState,
    this.querySnapshot,
  );
}
