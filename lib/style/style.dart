import 'package:flutter/material.dart';

class Style {
  static Color primaryMaroon = HexColor("#740247");
  static Color luxuryGold = HexColor("#D4AF37"); // Updated to v3 gold
  static Color luxuryCharcoal = HexColor("#080808"); // Updated to v3 dark
  static Color luxurySurface = HexColor("#121212"); // New v3 surface
  static Color luxuryOffWhite = HexColor("#F8F9FA");
  static Color luxuryGray = HexColor("#E5E5E5");
  static Color border = Colors.white.withValues(alpha: 0.08); // v3 border

  // Legacy mappings for compatibility
  static Color primaryColors = primaryMaroon;
  static Color secondaryColor = luxuryGold;
  static Color accentColor = luxuryCharcoal;
  static Color lavender = HexColor('#C197D2');
  static Color? lavenderBlack = HexColor('#211522');
  static Color orchid = HexColor('#613659');

  static String logoNoBackgroundAr = 'logo_no_background_ar';
  static String logoNoBackgroundTr = 'logo_no_background_tr';
  static String logoNoBackgroundEN = 'logo_no_background_en';

  static BoxDecoration glassBox({double opacity = 0.1, double blur = 10}) =>
      BoxDecoration(
        color: Colors.white.withValues(alpha: opacity),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        boxShadow: Shadows.subtle,
      );

  static BoxDecoration luxuryDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: Corners.lgBorder,
    boxShadow: Shadows.luxury,
  );
}

class FontSize {
  static double scale(BuildContext context, double fontSize) {
    final width = MediaQuery.of(context).size.width;

    // هاتف صغير
    if (width < 400) {
      return fontSize * 0.90;
    }

    // هاتف كبير
    if (width < 600) {
      return fontSize * 1.0;
    }

    // تابلت
    if (width < 900) {
      return fontSize * 1.15;
    }

    // شاشة كمبيوتر
    return fontSize * 1.30;
  }
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
      color: const Color(0xff333333).withValues(alpha: 0.4),
      spreadRadius: 2,
      blurRadius: 10,
    ),
  ];

  static List<BoxShadow> get luxury => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      spreadRadius: 0,
      blurRadius: 30,
      offset: const Offset(0, 10),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.03),
      spreadRadius: 0,
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get subtle => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      spreadRadius: 0,
      blurRadius: 10,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get small => [
    BoxShadow(
      color: const Color(0xff333333).withValues(alpha: 0.06),
      spreadRadius: 0,
      blurRadius: 3,
      offset: const Offset(0, 1),
    ),
  ];
}

class Corners {
  static const double sm = 8;
  static const Radius smRadius = Radius.circular(sm);
  static const BorderRadius smBorder = BorderRadius.all(smRadius);

  static const double med = 16;
  static const Radius medRadius = Radius.circular(med);
  static const BorderRadius medBorder = BorderRadius.all(medRadius);

  static const double lg = 24;
  static const Radius lgRadius = Radius.circular(lg);
  static const BorderRadius lgBorder = BorderRadius.all(lgRadius);

  static const double xl = 32;
  static const Radius xlRadius = Radius.circular(xl);
  static const BorderRadius xlBorder = BorderRadius.all(xlRadius);
}

class ButtonStyles {
  static ButtonStyle style = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.hovered)) {
        return Style.lavenderBlack!.withValues(alpha: 0.4);
      }
      if (states.contains(WidgetState.focused) ||
          states.contains(WidgetState.pressed)) {
        return Style.lavenderBlack!;
      }
      return Style.lavenderBlack!; // Defer to the widget's default.
    }),
  );
  static ButtonStyle styleWhite = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.hovered)) {
        return Style.lavenderBlack!.withValues(alpha: 0.4);
      }
      if (states.contains(WidgetState.focused) ||
          states.contains(WidgetState.pressed)) {
        return Style.lavenderBlack!;
      }
      return Colors.white; // Defer to the widget's default.
    }),
  );
}
