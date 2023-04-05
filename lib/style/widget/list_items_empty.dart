




import 'package:betna/style/custom_text.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class ListItemsEmpty extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: S.of(context).kNoOffer,
            size: 36,
            color: Style.primaryColors,
          ),
          const SizedBox(
            height: 24,
          ),
            Icon(Icons.search_off,size: 48,color: Style.primaryColors,)
        ],

      ),
    );
  }

}