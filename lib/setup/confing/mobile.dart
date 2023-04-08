
import 'package:betna/setup/confing/web_mobile_calss.dart';
import 'package:flutter/foundation.dart';

class Mobile implements WM {


  @override
  configureApp() {
    if (kDebugMode) {
      print('RUN MOBILE');
    }
  }
}

WM getWBClass() => Mobile();
