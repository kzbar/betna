

import 'dart:ui';

class Style {
  static Color primaryColors = HexColor("#740247");
  static Color lavender = HexColor('#C197D2');
  static Color lavenderBlack = HexColor('#211522');
  static Color orchid = HexColor('#613659');
  static String logoNoBackgroundAr = 'logo_no_background_ar';
  static String logoNoBackgroundTr = 'logo_no_background_tr';
  static String logoNoBackgroundEN = 'logo_no_background_en';

}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
