




import 'package:betna/style/custom_text.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class ListItemsEmpty extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: S.of(context).kNoOffer,
            size: 16,
            color: Style.primaryColors,
          ),
          const SizedBox(
            height: 12,
          ),
            Icon(Icons.search_off,size: 24,color: Style.primaryColors,)
        ],

      ),
    );
  }

}