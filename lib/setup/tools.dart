import 'dart:async';
import 'dart:typed_data';

import 'package:betna/generated/l10n.dart';
import 'package:betna/setup/enumerators.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
const kPropertyType = [
  {'id': '1', 'ar': 'شقق', 'en': 'Apartments', 'tr': 'Daireler'},
  {
    'id': '2',
    'ar': 'شقق فندقية',
    'en': 'Hotel Appartments',
    'tr': 'Otel Daireleri'
  },
  {'id': '3', 'ar': 'Villas', 'en': 'Apartments', 'tr': 'villalar'},
  {'id': '4', 'ar': 'هوم اوفس', 'en': 'Home office', 'tr': 'Home office'}
];
const kProjectState = [
  {
    'id': '1',
    'ar': 'قيد الإنشاء',
    'en': 'under construction',
    'tr': 'Yapım aşamasındaki'
  },
  {
    'id': '2',
    'ar': 'جاهز للسكن',
    'en': 'Ready for housing',
    'tr': 'Konut projelerine hazır'
  },
  {
    'id': '3',
    'ar': 'مشروع استثماري',
    'en': 'Investment project',
    'tr': 'Yatırım projeleri'
  }
];

class Constants {
  static String timeAgoSinceDate(String dateString,
      {bool numericDates = true, required BuildContext context}) {
    DateTime date = DateTime.parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(date);
    if ((difference.inDays / 365).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} ${S.of(context).kYearsAgo}';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '${S.of(context).k1yearAgo}' : '${S.of(context).kLastYear}';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${S.of(context).kMonthsAgo((difference.inDays / 30).floor())}';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '${S.of(context).k1MonthAgo}' : '${S.of(context).kLastMonth}';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '${S.of(context).kWeeksAgo((difference.inDays / 7).floor())}';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '${S.of(context).k1WeekAgo}' : '${S.of(context).kLastWeek}';
    } else if (difference.inDays >= 2) {
      return '${S.of(context).kDaysAgo(difference.inDays)}';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '${S.of(context).k1DayAgo}' : '${S.of(context).kYesterday}';
    } else if (difference.inHours >= 2) {
      return '${S.of(context).kHoursAgo(difference.inHours)}';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '${S.of(context).k1HourAgo}' : '${S.of(context).kAnHourAgo}';
    } else if (difference.inMinutes >= 2) {
      return '${S.of(context).kMinutesAgo(difference.inMinutes)}';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '${S.of(context).k1MinuteAgo}' : '${S.of(context).kAMinuteAgo}';
    } else if (difference.inSeconds >= 3) {
      return '${S.of(context).kFewSecondsAgo}';
    } else {
      return '${S.of(context).kJustNow}';
    }
  }

  static String convertPrice(BuildContext context, String price) {
    MainProvider provider = Provider.of<MainProvider>(context, listen: false);
    Currency? currency = provider.currency;
    Map currencyMap = provider.currencyMap ?? {};
    Map currencyMapUSD = provider.currencyMapUSD ??{};
    double currencyPrice = double.parse(price);
    double cUSD = currencyMapUSD.isNotEmpty ? double.parse(currencyMapUSD['price']['c'].toString()) : 0.0;
    double c = currency == Currency.TRY
        ? double.parse(price)
        : double.parse(currencyMap['price']['c'].toString());
    String? symbol = currency == Currency.TRY ? '₺' : currencyMap['symbol'];
    String result;
    switch (currency) {
      case Currency.TRY:
        result = price;
        break;
      case Currency.USD:
        result = "${(currencyPrice / c).ceil()}";
        break;
      case Currency.EUR:
        result = "${(currencyPrice / c).ceil()}";
        break;
      case Currency.SAR:
        result = "${(currencyPrice / c).ceil()}";
        break;
      case Currency.KWD:
        result = "${(currencyPrice / c).ceil()}";
        break;
      case Currency.QAR:
        result = "${(currencyPrice / c).ceil()}";
        break;
      case Currency.GBP:
        result = "${(currencyPrice / c).ceil()}";
        break;
      case Currency.JOD:
        result = "${(currencyPrice / c).ceil()}";
        break;
      case Currency.AED:
        result = "${(currencyPrice / c).ceil()}";
        break;
      case Currency.IQD:
        double _c = currencyPrice / cUSD;
        result = "${(_c / c).ceil()}";
        break;
      case Currency.YER:
        double _c = currencyPrice / cUSD;

        result = "${(_c / c).ceilToDouble()}";
        break;
      case Currency.LYD:
        double _c = currencyPrice / cUSD;

        result = "${(_c / c).ceil()}";
        break;
      default:
        {
          result = price;
        }
    }
    return '${_formatNumber(result)} $symbol';
  }

  static String _formatNumber(String string) {
    final format = NumberFormat.decimalPattern('en');
    return format.format(double.parse(string,));
  }

  static bool checkIsNewItem(String dateString){
    DateTime date = DateTime.parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(date);
    if (difference.inDays == 0 || difference.inDays == 1)
      return true;

    return false;
  }
}
class Capture {
  Future<Uint8List> capturePng(BuildContext context,GlobalKey _globalKey) async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 9);
      ByteData byteData = await (image.toByteData(format: ui.ImageByteFormat.png) as FutureOr<ByteData>);
      var pngBytes = byteData.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

}
