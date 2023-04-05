import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:betna/generated/l10n.dart';
import 'package:betna/models/address_model.dart';
import 'package:betna/models/sale_ad_model.dart';
import 'package:betna/setup/tools.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/popover/context_menu_overlay.dart';
import 'package:betna/style/style.dart';
import 'package:betna/style/widget/ImageView.dart';
import 'package:flutter/material.dart';

class UrgentRowItem extends StatefulWidget {
  final SaleAdModel? model;
  final String? tag;

  const UrgentRowItem({Key? key, this.model, this.tag}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UrgentRowItem();
}

class _UrgentRowItem extends State<UrgentRowItem> {
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
                color: Colors.white,
                borderRadius: Corners.lgBorder,
                boxShadow: Shadows.small),
            width: 150,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: '${widget.model!.adId!}${widget.tag}',
                      child: ClipRRect(
                        borderRadius: Corners.lgBorderTop,
                        child: ImageView(
                          height: 150 ,
                          width: 150,
                          image: widget.model!.images!.isNotEmpty
                              ? widget.model!.images![0]
                              : '',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 3
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InfoTextWidget(
                            text1: S.of(context).rooms,
                            text2: widget.model!.room,
                          ),
                          // InfoTextWidget(
                          //   text1: S.of(context).kArea,
                          //   text2: widget.model!.area,
                          // ),
                          InfoTextWidget(
                            text1: S.of(context).kFloor,
                            text2: widget.model!.floor,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 2.0),
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
                      size: 18,
                      color: Style.primaryColors,
                      weight: FontWeight.bold,
                      textDirection: TextDirection.ltr,
                    ),)
                  ],
                ),

                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    color: Colors.white70,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.only(),
                    child: CustomText(
                      text: widget.model!.adId,
                      color: Style.lavenderBlack,
                      weight: FontWeight.bold,
                      height: 1,
                      size: 12,
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
            color: Colors.black,
            size: 8,
          ),
          const SizedBox(
            width: 2,
          ),
          CustomText(
            text: text2,
            color: Style.primaryColors,
            weight: FontWeight.bold,
            size: 10,
          ),
        ],
      ),
    );
  }
}
