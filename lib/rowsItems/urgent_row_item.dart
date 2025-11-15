import 'package:betna/generated/l10n.dart';
import 'package:betna/models/address_model.dart';
import 'package:betna/models/sale_ad_model.dart';
import 'package:betna/pages/details_sale_screen.dart';
import 'package:betna/setup/tools.dart';
import 'package:betna/style/custom_text.dart';
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

    return  IgnorePointer(
      ignoring: !widget.model!.available!,
      child: RepaintBoundary(
        key: _globalKey,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
                settings:
                RouteSettings(name: 'sale?id=${widget.model!.adId}'),
                pageBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return DetailsSale(
                    kModel: widget.model,
                    tag: widget.tag!,
                    fromUrl: false,
                  );
                }));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: Corners.lgBorder,
                boxShadow: Shadows.small),
            width: 145,
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
                          height: 100 ,
                          width: 145,
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
                            text1: "S.of(context).rooms",
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
                      size: 12,
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
                Visibility(
                    visible: !widget.model!.available!,
                    child: Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,

                      child: Container(
                        decoration: BoxDecoration(
                          color: Style.primaryColors.withOpacity(0.5),
                          borderRadius: Corners.lgBorder,
                        ),

                        child: Center(child: DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 24,
                            fontFamily: 'LBC',
                            shadows: [
                              Shadow(
                                blurRadius: 8.0,
                                color: Colors.black26,
                                offset: Offset(0, 1),
                              ),
                              Shadow(
                                blurRadius: 8.0,
                                color: Colors.black26,
                                offset: Offset(1, 2),
                              ),
                            ],
                          ),
                          child: CustomText(
                            text: 'Sold',
                            size: 24,
                            color: Colors.white,
                          ),
                        ),),
                      ),
                    ))
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
            size: 8,
          ),
        ],
      ),
    );
  }
}
