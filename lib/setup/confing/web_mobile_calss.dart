

import 'package:betna/setup/confing/wb_interface.dart'

// ignore: uri_does_not_exist
if (dart.library.io)  'package:betna/setup/confing/mobile.dart'
// ignore: uri_does_not_exist
if (dart.library.html) 'package:betna/setup/confing/web.dart';



abstract class WM{
  void configureApp();
  factory WM() => getWBClass();

}