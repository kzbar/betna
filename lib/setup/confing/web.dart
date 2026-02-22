





import 'package:betna/setup/confing/web_mobile_calss.dart';
import 'package:flutter_web_plugins/url_strategy.dart';


class Web implements WM{

  @override
  void configureApp() {
    usePathUrlStrategy();
  }




}
WM getWBClass() => Web();
