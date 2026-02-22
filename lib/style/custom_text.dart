import 'package:betna/setup/enumerators.dart';
import 'package:betna/providers/main_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final double height;
  final Color? color;
  final FontWeight? weight;
  final String? fontFamily;
  final TextAlign textAlign;
  final TextDirection? textDirection;

  // name constructor that has a positional parameters with the text required
  // and the other parameters optional
  CustomText({
    required this.text,
    this.size,
    this.color,
    this.weight,
    this.fontFamily,
    this.textAlign = TextAlign.center,
    this.textDirection,
    this.height = 1,
  });

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<MainProvider>(context);

    return Text(
      text!,
      textAlign: textAlign,
      textDirection: textDirection ?? appProvider.textDecoration,
      style: TextStyle(
        height: height,
        fontSize: size ?? 16,
        color: color ?? Colors.black,
        fontWeight: weight ?? FontWeight.normal,
        fontFamily: fontFamily == 'ar' ? 'LBC' : 'AEOB',
      )

    );
  }
}
