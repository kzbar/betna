import 'package:betna/setup/enumerators.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final double letterSpacing;
  final double height;
  final Color? color;
  final FontWeight? weight;
  final String? fontFamily;
  final TextAlign textAlign;
  final TextDirection? textDirection;

  // name constructor that has a positional parameters with the text required
  // and the other parameters optional
  CustomText(
      {required this.text,
      this.size,
      this.color,
      this.weight,
      this.fontFamily,
      this.textAlign = TextAlign.center,
      this.textDirection,
      this.letterSpacing = 0,
      this.height = 1});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<MainProvider>(context);

    return Text(
      text!,
      textAlign: textAlign,
      textDirection:
          textDirection ?? appProvider.textDecoration,
      style: appProvider.currentLang == Lang.AR
          ? GoogleFonts.changa(
              height: height,
              letterSpacing: letterSpacing,
              fontSize: size ?? 16,
              color: color ?? Colors.black,
              fontWeight: weight ?? FontWeight.normal,
            )
          : GoogleFonts.cambay(
              height: height,
              letterSpacing: letterSpacing,
              fontSize: size ?? 16,
              color: color ?? Colors.black,
              fontWeight: weight ?? FontWeight.normal,
            ),
    );
  }
}
