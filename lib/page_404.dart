import 'package:betna/generated/l10n.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';

class Page404 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/logo_1.png',
                  width: 200,
                  height: 300,
                ),
                CustomText(
                  text: S.of(context).kPageNotFound,
                  color: Colors.red,
                  size: 48,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Style.primaryColors.withOpacity(0.4);
                          }
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.pressed)) {
                            return Style.primaryColors;
                          }
                          return Style
                              .primaryColors; // Defer to the widget's default.
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    child: CustomText(
                      text: S.of(context).kBackToHome,
                      color: Style.primaryColors,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
