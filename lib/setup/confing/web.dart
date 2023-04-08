





import 'package:betna/setup/confing/web_mobile_calss.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';


class Web implements WM{

  @override
  configureApp() {
    setUrlStrategy(PathUrlStrategy());
  }




}
WM getWBClass() => Web();
