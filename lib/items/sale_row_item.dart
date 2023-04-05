import 'package:betna/generated/l10n.dart';
import 'package:betna/models/address_model.dart';
import 'package:betna/models/sale_ad_model.dart';
import 'package:betna/setup/tools.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/popover/context_menu_overlay.dart';
import 'package:betna/style/style.dart';
import 'package:betna/style/widget/ImageView.dart';
import 'package:flutter/material.dart';

class SaleRowItem extends StatefulWidget {
  final SaleAdModel? model;
  final String? tag;

  const SaleRowItem({Key? key, this.model, this.tag}) : super(key: key);

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
      child: RepaintBoundary(
        key: _globalKey,
        child: InkWell(
          onTap: () {
            // Navigator.of(context).push(PageRouteBuilder(
            //     settings: RouteSettings(name: 'sale?id=${widget.model!.adId}'),
            //     pageBuilder: (BuildContext context, Animation<double> animation,
            //         Animation<double> secondaryAnimation) {
            //       return DetailsSale(
            //         model: widget.model,
            //         tag: widget.tag,
            //       );
            //     }));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: Corners.lgBorder,
                boxShadow: Shadows.small),
            width: 300,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: '${widget.model!.adId!}${widget.tag}',
                      child: ClipRRect(
                        borderRadius: Corners.lgBorderTop,
                        child: ImageView(
                          height: 300 * 0.75,
                          width: 300,
                          image: widget.model!.images!.isNotEmpty
                              ? widget.model!.images![0]
                              : '',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InfoTextWidget(
                            text1: S.of(context).rooms,
                            text2: widget.model!.room,
                          ),
                          InfoTextWidget(
                            text1: S.of(context).kArea,
                            text2: widget.model!.area,
                          ),
                          InfoTextWidget(
                            text1: S.of(context).kFloor,
                            text2: widget.model!.floor,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InfoTextWidget(
                            text1: S.of(context).kCity,
                            text2:
                                '${Address.fromMap(widget.model!.address!).city!.name}/${Address.fromMap(widget.model!.address!).town!.name}',
                          ),
                        ],
                      ),
                    ),
                    Container(padding: const EdgeInsets.only(left: 6,right: 6),child: CustomText(
                      text: Constants.convertPrice(
                          context, widget.model!.price!),
                      size: 24,
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
                                    widget.model!.date!.millisecondsSinceEpoch)
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
                                          .model!.date!.millisecondsSinceEpoch)
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
                  bottom: 124,
                  left: 12,
                  child: Column(
                    textDirection: TextDirection.ltr,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: widget.model!.affordableHomes! == 'yes'
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
                      text: widget.model!.adId,
                      color: Style.lavenderBlack,
                      weight: FontWeight.bold,
                      height: 1,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
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
            size: 16,
          ),
          const SizedBox(
            width: 4,
          ),
          CustomText(
            text: text2,
            color: Style.primaryColors,
            weight: FontWeight.bold,
            size: 16,
          ),
        ],
      ),
    );
  }
}
