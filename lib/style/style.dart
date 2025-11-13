

import 'dart:ui';

import 'package:flutter/material.dart';

class Style {
  static Color primaryColors = HexColor("#740247");
  static Color lavender = HexColor('#C197D2');
  static Color? lavenderBlack = HexColor('#211522');
  static Color orchid = HexColor('#613659');
  static String logoNoBackgroundAr = 'logo_no_background_ar';
  static String logoNoBackgroundTr = 'logo_no_background_tr';
  static String logoNoBackgroundEN = 'logo_no_background_en';

}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class Shadows {
  static List<BoxShadow> get universal => [
    BoxShadow(
        color: Color(0xff333333).withOpacity(0.4),
        spreadRadius: 2,
        blurRadius: 10),
  ];

  static List<BoxShadow> get universal2 => [
    BoxShadow(
        color: Colors.grey.withAlpha(70),
        spreadRadius: 2,
        blurRadius: 2,
        offset: Offset(0.5, 0)),
  ];

  static List<BoxShadow> get small => [
    BoxShadow(
        color: Color(0xff333333).withAlpha(15),
        spreadRadius: 0,
        blurRadius: 3,
        offset: Offset(0, 1)),
  ];
}

class Corners {
  static const double sm = 3;
  static const BorderRadius smBorder = const BorderRadius.all(smRadius);
  static const BorderRadius smBorderTop =
  const BorderRadius.only(topLeft: smRadius, topRight: smRadius);
  static const Radius smRadius = const Radius.circular(sm);

  static const double med = 5;
  static const BorderRadius medBorder = const BorderRadius.all(medRadius);
  static const BorderRadius medBorderTop =
  const BorderRadius.only(topLeft: medRadius, topRight: medRadius);

  static const Radius medRadius = const Radius.circular(med);

  static const double lg = 8;
  static const BorderRadius lgBorder = const BorderRadius.all(lgRadius);
  static const BorderRadius lgBorderTop =
  const BorderRadius.only(topLeft: lgRadius, topRight: lgRadius);

  static const Radius lgRadius = const Radius.circular(lg);
}

class ButtonStyles {
  static ButtonStyle style = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) {
          return Style.lavenderBlack!.withOpacity(0.4);
        }
        if (states.contains(WidgetState.focused) ||
            states.contains(WidgetState.pressed)) {
          return Style.lavenderBlack!;
        }
        return Style.lavenderBlack!; // Defer to the widget's default.
      },
    ),
  );
  static ButtonStyle styleWhite = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered))
          return Style.lavenderBlack!.withOpacity(0.4);
        if (states.contains(WidgetState.focused) ||
            states.contains(WidgetState.pressed)) {
          return Style.lavenderBlack!;
        }
        return Colors.white; // Defer to the widget's default.
      },
    ),
  );
}
