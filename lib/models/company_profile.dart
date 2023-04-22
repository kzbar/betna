import 'package:betna/setup/enumerators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyProfile {
  CompanyProfile({this.textAr, this.textEn, this.textTr});

  String? textAr ='';
  String? textEn ='';
  String? textTr = '';

  factory CompanyProfile.copy(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return CompanyProfile(
      textAr: snapshot.data()!['TEXT_AR'] ,
      textTr: snapshot.data()!['TEXT_TR'],
      textEn: snapshot.data()!['TEXT_EN'],
    );
  }

  String getText(Lang lang) {
    String val;
    switch(lang){
      case Lang.AR:
       val= textAr!;
        break;
      case Lang.EN:
        val= textEn!;
        break;
      case Lang.TR:
        val= textTr!;
        break;
      default:
        val = '';
    }
    return val;
  }

}
