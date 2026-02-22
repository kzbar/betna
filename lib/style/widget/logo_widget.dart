

import 'package:betna/setup/enumerators.dart';
import 'package:betna/providers/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, required this.withBackground,  this.hi = 100,  this.we = 150});

  final bool withBackground;
  final double hi;
  final double we;

  @override
  Widget build(BuildContext context) {
    Lang? lang = Provider.of<MainProvider>(context, listen: false).currentLang;
    String logo;
    if (withBackground) {
      switch (lang) {
        case Lang.AR:
          logo = 'assets/logo/logoA.png';
          break;
        case Lang.EN:
          logo = 'assets/logo/logoE.png';
          break;
        case Lang.TR:
          logo = 'assets/logo/logoT.png';
          break;
        default:
          {
            logo = 'assets/logo/logoE.png';
          }
      }
    } else {
      switch (lang) {
        case Lang.AR:
          logo = 'assets/logo/logo_no_background_ar.png';
          break;
        case Lang.EN:
          logo = 'assets/logo/logo_no_background_en.png';
          break;
        case Lang.TR:
          logo = 'assets/logo/logo_no_background_tr.png';
          break;
        default:
          {
            logo = 'assets/logo/logo_no_background_en.png';
          }
      }
    }
    return Container(
      margin: const EdgeInsets.only(top: 0),
      child: Image.asset(
        logo,
        width: we,
        height: hi,
        fit: BoxFit.contain,
      ),
    );
  }
}
