import 'package:betna/generated/l10n.dart';
import 'package:betna/models/company_profile.dart';
import 'package:betna/setup/enumerators.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutAs extends StatelessWidget {
  final EdgeInsetsGeometry? edgeInsetsGeometry;
  final double textSize;
  const AboutAs({super.key, required this.edgeInsetsGeometry, required this.textSize});

  @override
  Widget build(BuildContext context) {
    Lang? lang = Provider.of<MainProvider>(context, listen: false).currentLang;
    String? des;

    return FutureBuilder(
      future: getSettingApp(),
      builder: (BuildContext context, AsyncSnapshot<CompanyProfile?> snapshot) {
        if (snapshot.hasData)
        {
          switch (lang) {
            case Lang.AR:
              des = snapshot.data!.textAr;
              break;
            case Lang.EN:
              des = snapshot.data!.textEn;
              break;
            case Lang.TR:
              des = snapshot.data!.textTr;
              break;
            default:
              des = '';
          }
          return Container(
            margin: edgeInsetsGeometry,
            child: Column(
              children: [
                Divider(
                  color: Style.lavenderBlack,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12, top: 6),
                  child: CustomText(
                    text: S.of(context).kAbout,
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                ),
                CustomText(
                  text: des,
                  size: textSize,
                  textAlign: TextAlign.start,
                  textDirection:
                      lang == Lang.AR ? TextDirection.rtl : TextDirection.ltr,
                  color: Colors.black,
                  height: 1.6,
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
  Future<CompanyProfile> getSettingApp() async {
    return FirebaseFirestore.instance
        .collection('app_settings')
        .doc('CompanyProfile')
        .get()
        .then((value) {
      return Future.value(CompanyProfile.copy(value));
    });
  }

}
