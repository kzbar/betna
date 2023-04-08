




import 'package:betna/setup/tools.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/popover/context_menu_overlay.dart';
import 'package:betna/style/responsive/responsive_builder.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';

import '../style/responsive/device_screen_type.dart';
import '../style/widget/skeleton.dart';

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
        child: ResponsiveBuilder(builder: (context,size){
          double width = 0.0;
          double imageHeight = 0.0;
          double fontSize = 20;
          double fontSizePrice = 20;
          double bottom = 0.0;
          double top = 0.0;
          switch(size.deviceScreenType){
            case DeviceScreenType.Mobile:
              width = 210;
              imageHeight = 190;
              fontSizePrice = 20;
              fontSize = 12;
              bottom = 100;
              top = 12;
              break;
            case DeviceScreenType.Tablet:
            // TODO: Handle this case.
              break;
            case DeviceScreenType.Desktop:
              width = 300;
              imageHeight = 280;
              fontSize = 16;
              bottom = 124;
              fontSizePrice = 24;
              top = 20;


              break;
            default:
              width = 300;
              imageHeight = 280;
              fontSize = 16;
              bottom = 124;
              fontSizePrice = 24;
              top = 20;


              break;


          }

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: Corners.lgBorder,
                boxShadow: Shadows.small),
            width: width,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: Corners.lgBorderTop,
                      child: Skeleton(
                        cornerRadius: 0.0,
                        height: imageHeight * 0.75,
                        width: width,
                        showCircular: false,
                      ),
                    ),
                    Container(
                      margin:  EdgeInsets.only(
                        top: top,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          InfoTextWidget(
                            size: fontSize,
                            text1: 'Loading',
                            text2: '',
                          ),
                          InfoTextWidget(
                            size: fontSize,
                            text1: 'Loading',
                            text2: '',
                          ),
                          InfoTextWidget(
                            size: fontSize,
                            text1: 'Loading',
                            text2: '',
                          ),
                        ],
                      ),
                    ),

                    CustomText(
                      text: Constants.convertPrice(context, "1000000"),
                      size: fontSizePrice,
                      color: Colors.white,
                      weight: FontWeight.bold,
                      textDirection: TextDirection.ltr,
                    ),


                  ],
                ),
                // Positioned(
                //   top: 12,
                //   left: 12,
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(horizontal: 6.0),
                //     margin: const EdgeInsets.only(),
                //     height: 20,
                //     decoration: BoxDecoration(
                //         borderRadius: Corners.medBorder, color: Style.primaryColors),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: [
                //         CustomText(
                //           text: 'New'.toUpperCase(),
                //           size: 10,
                //           color: Colors.white,
                //         ),
                //         CustomText(
                //           text: ' - ',
                //           size: 10,
                //           color: Colors.white,
                //         ),
                //         CustomText(
                //           text: Constants.timeAgoSinceDate(
                //               DateTime.fromMillisecondsSinceEpoch(
                //                   DateTime.now().millisecondsSinceEpoch)
                //                   .toIso8601String(),context: context)
                //               .toUpperCase(),
                //
                //           size: 10,
                //           color: Colors.white,
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        },)
      ),
    );
  }
}
class InfoTextWidget extends StatelessWidget {
  final String? text1;
  final String? text2;
  final double? size;

  const InfoTextWidget({Key? key, this.text1, this.text2,required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3),
      child: Row(
        children: [
          CustomText(
            text: text1,
            color: Colors.black45,
            size: size,
          ),
          const SizedBox(
            width: 4,
          ),
          CustomText(
            text: text2,
            color: Style.primaryColors,
            weight: FontWeight.bold,
            size: size,
          ),
        ],
      ),
    );
  }
}

