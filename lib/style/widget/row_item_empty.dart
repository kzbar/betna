




import 'package:betna/setup/tools.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/popover/context_menu_overlay.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';

import 'skeleton.dart';

class EmptyRowItem extends StatelessWidget {

  const EmptyRowItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ContextMenuRegion(
        contextMenu: TextButton(
          onPressed: () {},
          child: const Text('Share'),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: Corners.lgBorder,
              boxShadow: Shadows.small),
          width: 300,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: Corners.lgBorderTop,
                    child: Skeleton(
                      cornerRadius: 0.0,
                      height: 280 * 0.75,
                      width: 300,
                      showCircular: false,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        InfoTextWidget(
                          text1: 'Loading',
                          text2: '',
                        ),
                        InfoTextWidget(
                          text1: 'Loading',
                          text2: '',
                        ),
                        InfoTextWidget(
                          text1: 'Loading',
                          text2: '',
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        InfoTextWidget(
                          text1: 'Loading',
                          text2:
                          '',
                        ),
                        InfoTextWidget(
                          text1: 'Loading',
                          text2:
                          '',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  margin: const EdgeInsets.only(),
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: Corners.medBorder, color: Style.primaryColors),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomText(
                        text: 'New'.toUpperCase(),
                        size: 10,
                        color: Colors.white,
                      ),
                      CustomText(
                        text: ' - ',
                        size: 10,
                        color: Colors.white,
                      ),
                      CustomText(
                        text: Constants.timeAgoSinceDate(
                            DateTime.fromMillisecondsSinceEpoch(
                                DateTime.now().millisecondsSinceEpoch)
                                .toIso8601String(),context: context)
                            .toUpperCase(),

                        size: 10,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 90,
                left: 12,
                child: Column(
                  textDirection: TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Home',
                      size: 12,
                      color: Colors.white,
                    ),
                    CustomText(
                      text: Constants.convertPrice(context, "1000000"),
                      size: 20,
                      color: Colors.white,
                      weight: FontWeight.bold,
                      textDirection: TextDirection.ltr,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class InfoTextWidget extends StatelessWidget {
  final String? text1;
  final String? text2;

  const InfoTextWidget({Key? key, this.text1, this.text2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        children: [
          CustomText(
            text: text1,
            color: Colors.black45,
            size: 12,
          ),
          const SizedBox(
            width: 4,
          ),
          CustomText(
            text: text2,
            color: Colors.black,
            weight: FontWeight.bold,
            size: 13,
          ),
        ],
      ),
    );
  }
}

