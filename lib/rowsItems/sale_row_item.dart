import 'package:betna/generated/l10n.dart';
import 'package:betna/models/address_model.dart';
import 'package:betna/models/sale_ad_model.dart';
import 'package:betna/pages/details_sale_screen.dart';
import 'package:betna/setup/tools.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/popover/context_menu_overlay.dart';
import 'package:betna/style/responsive/responsive_builder.dart';
import 'package:betna/style/style.dart';
import 'package:betna/style/widget/ImageView.dart';
import 'package:flutter/material.dart';

import '../style/responsive/device_screen_type.dart';

class SaleRowItem extends StatefulWidget {
  final SaleAdModel model;
  final String? tag;

  const SaleRowItem({Key? key, required this.model, this.tag}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SaleRowItem();
}

class _SaleRowItem extends State<SaleRowItem> {
  bool isShare = false;
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    void _handleSharePressed() async {
      // setState(() {
      //   isShare = true;
      // });
      // try {
      //   Capture().capturePng(context, _globalKey).then((value) async {
      //     await WM()
      //         .saveAndLaunchImage(value, "${widget.model!.adId}.png")
      //         .then((value) {
      //       setState(() {
      //         isShare = false;
      //       });
      //     });
      //   });
      // } catch (error) {
      //   setState(() {
      //     isShare = false;
      //   });
      //   rethrow;
      // }
      // CloseContextMenuNotification().dispatch(context);
    }

    return ContextMenuRegion(
      contextMenu: TextButton(
        style: ButtonStyles.style,
        onPressed: _handleSharePressed,
        child: CustomText(
          text: S.of(context).kShare,
          color: Style.primaryColors,
        ),
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
            width = 220;
            imageHeight = 190;
            fontSizePrice = 20;
            fontSize = 10;
            bottom = 100;
            top = 12;
            break;
          case DeviceScreenType.Tablet:
            width = 300;
            imageHeight = 280;
            fontSize = 16;
            bottom = 130;
            fontSizePrice = 24;
            top = 20;

            break;
          case DeviceScreenType.Desktop:
            width = 300;
            imageHeight = 280;
            fontSize = 16;
            bottom = 130;
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

        return RepaintBoundary(
          key: _globalKey,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  settings: RouteSettings(name: 'sale?id=${widget.model.adId}'),
                  pageBuilder: (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return DetailsSale(
                      kModel: widget.model,
                      tag: widget.tag!, fromUrl: false,
                    );
                  }));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: Corners.lgBorder,
                  boxShadow: Shadows.universal),
              width: width,
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: '${widget.model.adId!}}',
                        child: ClipRRect(
                          borderRadius: Corners.lgBorderTop,
                          child: ImageView(
                            height: imageHeight * 0.75,
                            width: width,
                            image: widget.model.images!.isNotEmpty
                                ? widget.model.images![0]
                                : '',
                          ),
                        ),
                      ),
                      Container(
                        width: width,
                        margin:  EdgeInsets.only(
                          top: top
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InfoTextWidget(
                              text1: S.of(context).rooms,
                              size: fontSize,
                              text2: widget.model.room,
                            ),
                            InfoTextWidget(
                              text1: S.of(context).kArea,
                              size: fontSize,

                              text2: widget.model.area,
                            ),
                            InfoTextWidget(
                              text1: S.of(context).kFloor,
                              size: fontSize,

                              text2: widget.model.floor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InfoTextWidget(
                              text1: S.of(context).kCity,
                              size: fontSize,
                              text2:
                              '${Address.fromMap(widget.model.address!).city!.name}/${Address.fromMap(widget.model.address!).town!.name}',
                            ),
                          ],
                        ),
                      ),
                      Container(padding: const EdgeInsets.only(left: 6,right: 6),child: CustomText(
                        text: Constants.convertPrice(
                            context, widget.model.price!),
                        size: fontSizePrice,
                        color: Style.primaryColors,
                        weight: FontWeight.bold,
                        textDirection: TextDirection.ltr,
                      ),)
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
                          if (Constants.checkIsNewItem(
                              DateTime.fromMillisecondsSinceEpoch(
                                  widget.model.date!.millisecondsSinceEpoch)
                                  .toIso8601String())) ...[
                            CustomText(
                              text: S.of(context).kNew.toUpperCase(),
                              size: 10,
                              color: Colors.white,
                            ),
                            CustomText(
                              text: ' - ',
                              size: 10,
                              color: Colors.white,
                            ),
                          ],
                          CustomText(
                            text: Constants.timeAgoSinceDate(
                                DateTime.fromMillisecondsSinceEpoch(widget
                                    .model.date!.millisecondsSinceEpoch)
                                    .toIso8601String(),
                                context: context)
                                .toUpperCase(),
                            size: 10,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: bottom,
                    left: 12,
                    child: Column(
                      textDirection: TextDirection.ltr,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: widget.model.affordableHomes! == 'yes'
                              ? S.of(context).kAffordableHomes
                              : S.of(context).kLuxuryHomes,
                          size: 12,
                          color: Colors.white,
                        ),

                      ],
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      color: Colors.white70,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(4),
                      margin: const EdgeInsets.only(),
                      child: CustomText(
                        text: widget.model.adId,
                        color: Style.lavenderBlack,
                        weight: FontWeight.bold,
                        height: 1,
                        size: fontSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },),
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
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 3),
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
