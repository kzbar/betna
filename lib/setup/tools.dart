import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

const String chatGpt = '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';

const kPropertyType = [
  {'id': '1', 'ar': 'شقق', 'en': 'Apartments', 'tr': 'Daireler'},
  {
    'id': '2',
    'ar': 'شقق فندقية',
    'en': 'Hotel Appartments',
    'tr': 'Otel Daireleri',
  },
  {'id': '3', 'ar': 'Villas', 'en': 'Apartments', 'tr': 'villalar'},
  {'id': '4', 'ar': 'هوم اوفس', 'en': 'Home office', 'tr': 'Home office'},
];

const kProjectState = [
  {
    'id': '1',
    'ar': 'قيد الإنشاء',
    'en': 'under construction',
    'tr': 'Yapım aşamasındaki',
  },
  {
    'id': '2',
    'ar': 'جاهز للسكن',
    'en': 'Ready for housing',
    'tr': 'Konut projelerine hazır',
  },
  {
    'id': '3',
    'ar': 'مشروع استثماري',
    'en': 'Investment project',
    'tr': 'Yatırım projeleri',
  },
];

class Capture {
  Future<Uint8List> capturePng(
    BuildContext context,
    GlobalKey globalKey,
  ) async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 9);
      ByteData? byteData = await (image.toByteData(
        format: ui.ImageByteFormat.png,
      ));
      var pngBytes = byteData!.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
