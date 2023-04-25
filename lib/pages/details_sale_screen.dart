import 'dart:ui';

import 'package:betna/generated/l10n.dart';
import 'package:betna/models/address_model.dart';
import 'package:betna/models/sale_ad_model.dart';
import 'package:betna/services/firebase_collections_names.dart';
import 'package:betna/setup/general.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/setup/tools.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/responsive/device_screen_type.dart';
import 'package:betna/style/responsive/responsive_builder.dart';
import 'package:betna/style/style.dart';
import 'package:betna/style/widget/ImageView.dart';
import 'package:betna/style/widget/currency_widget.dart';
import 'package:betna/style/widget/hover_widget.dart';
import 'package:betna/style/widget/images_list.dart';
import 'package:betna/style/widget/images_page_view.dart';
import 'package:betna/style/widget/logo_widget.dart';
import 'package:betna/style/widget/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;
import 'package:translator/translator.dart';

import '../style/popover/popover_controller.dart';

class DetailsSale extends StatefulWidget {
  final SaleAdModel? kModel;
  final String? tag;
  final bool fromUrl;
  final String? id;

  const DetailsSale(
      {Key? key, this.kModel, this.tag, required this.fromUrl, this.id})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailsSale();
}

class _DetailsSale extends State<DetailsSale> {
  bool? _isDesktop;
  SaleAdModel? model;
  final translator = GoogleTranslator();
  late Address address;

  @override
  void initState() {
    if (!widget.fromUrl) {
      model = widget.kModel;
      address = Address.fromMap(model!.address!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? lang = Provider.of<MainProvider>(context, listen: false).kLang;
    return ResponsiveBuilder(builder: (context, size) {
      double w = MediaQuery.of(context).size.width;
      double h = MediaQuery.of(context).size.height;
      _isDesktop = size.deviceScreenType == DeviceScreenType.Desktop ||
          size.deviceScreenType == DeviceScreenType.Tablet;
      double horizontal = 0.0;
      switch (size.deviceScreenType) {
        case DeviceScreenType.Mobile:
          break;
        case DeviceScreenType.Tablet:
          horizontal = 0.05;
          break;
        case DeviceScreenType.Desktop:
          horizontal = 0.25;
          break;
        default:
      }
      return SafeArea(
          child: PopOverController(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          // floatingActionButton: ContactNumber(),
          body: Scrollbar(
            child: FutureBuilder(
              future: widget.fromUrl ? getAd() : Future.value(model),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  );
                }
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width,
                      color: Style.lavenderBlack,
                      child: Container(
                        margin: _isDesktop!
                            ? EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.16,
                                0,
                                MediaQuery.of(context).size.width * 0.12,
                                0)
                            : const EdgeInsets.only(),
                        child: Row(
                          textDirection: TextDirection.ltr,
                          children: [
                             Container(padding: const EdgeInsets.symmetric(horizontal: 12),child: const Logo(withBackground: false,),),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.06,
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: HoverWidget(
                                widget: Row(
                                  textDirection: TextDirection.ltr,
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.phone,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    CustomText(
                                      text: '+90 5525 333 666',
                                      size: 20,
                                      color: Colors.white,
                                      textDirection: TextDirection.ltr,
                                    )
                                  ],
                                ),
                                backgroundColor: Colors.transparent,
                                backgroundColorHover: Style.orchid,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            // LanguageButton(
                            //   deviceScreenType:
                            //       getDeviceType(MediaQuery.of(context)),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(bottom: h * 0.10),
                        margin:
                        EdgeInsets.symmetric(horizontal: w * horizontal),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///VIDEO
                            if (model!.videoUrl != null && model!.videoUrl!.isNotEmpty) ...[
                              Row(
                                children: [
                                  Expanded(
                                    child: _isDesktop!
                                        ? SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.75,
                                            child: ViedoPlayerView(
                                              model: model!,
                                            ),
                                          )
                                        : ViedoPlayerView(
                                            model: model!,
                                          ),
                                  )
                                ],
                              ),
                            ] else ...[
                              ///Image
                              Container(
                                color: Colors.transparent,
                                height: _isDesktop! ? h * 0.40 : h * 0.35,
                                child: Stack(
                                  children: [
                                    model!.images!.isNotEmpty
                                    ? InkWell(
                                      child: Hero(
                                        tag: '${model!.adId!}${widget.tag}',
                                        child: ImageView(
                                          image: model!.images![0]!??'',
                                          width: w,
                                          height:
                                          _isDesktop! ? h * 0.40 : h * 0.35,
                                        ),
                                      ),
                                      onTap: () {
                                        Get.to(() => ImagePageView(
                                          images: model!.images,
                                          tag:
                                          "${widget.tag}",
                                        ));
                                      },
                                    ):Hero(
                                      tag: '${model!.adId!}${widget.tag}',
                                      child: ImageView(
                                        image: '',
                                        width: w,
                                        fit: BoxFit.fill,
                                        height:
                                        _isDesktop! ? h * 0.40 : h * 0.35,
                                      ),
                                    ),
                                    Positioned(
                                        right: 12,
                                        top: 24,
                                        left: 12,
                                        child: Row(
                                          textDirection: TextDirection.rtl,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Get.to(() => ImagePageView(
                                                        images: model!.images,
                                                        tag:
                                                            "${model!.adId!}${widget.tag}",
                                                      ));
                                                },
                                                icon: Icon(
                                                  Icons.photo_library_rounded,
                                                  color: Style.orchid,
                                                )),
                                            const Spacer(),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                icon: const Icon(
                                                  Icons.close_sharp,
                                                  color: Colors.white,
                                                )),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ],

                            ///IMAGES
                            Container(
                              height: 80,
                              alignment: Alignment.center,
                              child: ImageList(
                                adId: model!.adId!,
                                photosList: model!.images,
                              ),
                            ),

                            ///TITLE
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 12.0, bottom: 0.0, left: 12, right: 12),
                              child: CustomText(
                                text: model!.title[lang],
                                textAlign: TextAlign.start,
                                height: 1.5,
                                size: 24,
                              ),
                            ),

                            ///ADDRESS
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 1.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Style.primaryColors,
                                  ),
                                  CustomText(
                                    color: Style.primaryColors,
                                    size: 10,
                                    height: 1,
                                    text:
                                        '${address.city!.name!.toLowerCase()},${address.neighborhoods!.name!.toLowerCase()},${address.street!.toLowerCase()}',
                                  )
                                ],
                              ),
                            ),

                            ///info 1
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Style.primaryColors,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6.0))),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 6.0),
                                  padding: const EdgeInsets.all(6.0),
                                  child: CustomText(
                                    color: Colors.white,
                                    textAlign: TextAlign.start,
                                    text: model!.affordableHomes! == 'yes'
                                        ? S.of(context).kAffordableHomes
                                        : S.of(context).kLuxuryHomes,
                                    size: 10,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Style.primaryColors,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6.0))),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 6.0),
                                  padding: const EdgeInsets.all(6.0),
                                  child: CustomText(
                                    color: Colors.white,
                                    textAlign: TextAlign.start,
                                    text: model!.propertyCase! == 'yes'
                                        ? S.of(context).kHouseNew
                                        : S.of(context).kHouseOld,
                                    size: 10,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Style.lavenderBlack,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6.0))),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 6.0),
                                  padding: const EdgeInsets.all(6.0),
                                  child: CustomText(
                                    color: Colors.white,
                                    textAlign: TextAlign.start,
                                    text: model!.state['id']! == '1'
                                        ? S.of(context).kHouseState1
                                        : model!.state['id']! == '2'
                                            ? S.of(context).kHouseState2
                                            : S.of(context).kHouseState3,
                                    size: 10,
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  child: CustomText(
                                    size: 12,
                                    color: Colors.redAccent,
                                    text: model!.state['id']! == '1'
                                        ? ''
                                        : S.of(context).kYouShouldTakeDate(
                                              model!.state['id']! == '2'
                                                  ? S.of(context).kHouseState2
                                                  : S.of(context).kHouseState3,
                                            ),
                                  ),
                                ))
                              ],
                            ),

                            ///Explanation
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 12, bottom: 6, right: 12, left: 12),
                              child: CustomText(
                                color: Style.primaryColors,
                                textAlign: TextAlign.start,
                                text: S.of(context).kExplanation,
                                size: 20,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 1.0),
                              child: CustomText(
                                text: model!.explanation[lang],
                                textAlign: TextAlign.start,
                                height: 1.5,
                              ),
                            ),

                            /// Ad info

                            ///Change Currency
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 12.0),
                                  child: CustomText(
                                    color: Style.primaryColors,
                                    textAlign: TextAlign.start,
                                    text: S.of(context).kAdInfo,
                                    size: 20,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: CustomText(
                                    text: S.of(context).kChangeCurrency,
                                    color: Colors.grey.shade600,
                                    size: 10,
                                  ),
                                ),
                                const CurrencyWidget(
                                  alignmentAR: Alignment.topCenter,
                                  alignmentEN: Alignment.topRight,
                                )
                              ],
                            ),

                            const SizedBox(
                              height: 12,
                            ),

                            info(S.of(context).kAdId, model!.adId!, w),
                            info(
                                S.of(context).kPrice,
                                Constants.convertPrice(context, model!.price!),
                                w),
                            info(
                                S.of(context).kDateAdded,
                                intl.DateFormat("yyyy-MM-dd", 'en')
                                    .format(model!.date!.toDate()),
                                w),

                            info(S.of(context).kRoom, model!.room!, w),
                            info(S.of(context).kFloor, model!.floor!, w),
                            info(S.of(context).kFloors, model!.floors!, w),
                            info(S.of(context).kAreaAll, model!.area!, w),
                            info(S.of(context).kAreaNet, model!.netArea!, w),
                            info(S.of(context).kAgeBuilding,
                                model!.ageBuilding!, w),
                            info(
                                S.of(context).kBalcony,
                                model!.balcony! == 'yes'
                                    ? S.of(context).kThereIs
                                    : S.of(context).kThereIsNot,
                                w),
                            info(
                                S.of(context).kBathrooms, model!.bathrooms!, w),
                            info(
                                S.of(context).kInSideSite,
                                model!.insideSite! == 'yes'
                                    ? S.of(context).kYes
                                    : S.of(context).kNo,
                                w),
                            info(S.of(context).kTypesHeating,
                                model!.typesHeating![lang], w),
                            info(
                                S.of(context).kLastModified,
                                intl.DateFormat("yyyy-MM-dd", 'en')
                                    .format(model!.lastModified!.toDate()),
                                w),
                            if (model!.externalFeatures!.isNotEmpty) ...[
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 12, bottom: 6, right: 12, left: 12),
                                child: CustomText(
                                  color: Style.primaryColors,
                                  textAlign: TextAlign.start,
                                  text: S.of(context).kExternalFeatures,
                                  size: 20,
                                ),
                              ),
                              items(model!.externalFeatures!,
                                  'external_features', lang),
                            ],
                            if (model!.internalFeatures!.isNotEmpty) ...[
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 12, bottom: 6, right: 12, left: 12),
                                child: CustomText(
                                  color: Style.primaryColors,
                                  textAlign: TextAlign.start,
                                  text: S.of(context).kInternalFeatures,
                                  size: 20,
                                ),
                              ),
                              items(model!.internalFeatures!,
                                  'internal_features', lang),
                            ],
                            if (model!.transportation!.isNotEmpty) ...[
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 12, bottom: 6, right: 12, left: 12),
                                child: CustomText(
                                  color: Style.primaryColors,
                                  textAlign: TextAlign.start,
                                  text: S.of(context).kTransportation,
                                  size: 20,
                                ),
                              ),
                              items(model!.transportation!, 'transportation',
                                  lang),
                            ],
                            if (model!.neighborhood!.isNotEmpty) ...[
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 12, bottom: 6, right: 12, left: 12),
                                child: CustomText(
                                  color: Style.primaryColors,
                                  textAlign: TextAlign.start,
                                  text: S.of(context).kNeighborhood,
                                  size: 20,
                                ),
                              ),
                              items(model!.neighborhood!, 'neighborhood', lang),
                            ],
                            if (model!.view!.isNotEmpty) ...[
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 12, bottom: 6, right: 12, left: 12),
                                child: CustomText(
                                  color: Style.primaryColors,
                                  textAlign: TextAlign.start,
                                  text: S.of(context).kView,
                                  size: 20,
                                ),
                              ),
                              items(model!.view!, 'view', lang),
                            ],
                            const SizedBox(
                              height: 36,
                            ),

                            // Center(
                            //   child: TextButton(
                            //       style: ButtonStyles.style,
                            //       onPressed: () {
                            //         //showBottomSheet(context);
                            //       },
                            //       child: CustomText(
                            //         color: Style.primaryColors,
                            //         size: 16.0,
                            //         text: S.of(context).kTakeAppointment,
                            //       )),
                            // )
                          ],
                        ),
                      ),
                    ))
                  ],
                );
              },
            ),
          ),
        ),
      ));
    });
  }

  Future<SaleAdModel> getAd() async {
    if (widget.fromUrl) {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection(FirebaseCollectionNames.SalesCollection)
              .doc(widget.id)
              .get();
      setState(() {
        model = SaleAdModel.fromMap(documentSnapshot.data()!);
        address = Address.fromMap(model!.address!);
      });
    } else {
      setState(() {
        model = widget.kModel;
        address = Address.fromMap(model!.address!);
      });
    }
    return Future.value(model);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // void showBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       routeSettings: RouteSettings(
  //           name: 'takeAppointment?reference=SALE_${widget.model!.adId}'),
  //       backgroundColor: Colors.transparent,
  //       builder: (BuildContext context) {
  //         return TakeAppointment(
  //           reference: 'SALE_${widget.model!.adId!}',
  //         );
  //       },
  //       context: context);
  // }

  Widget items(List items, String listName, String lang) {
    List names = forSaleElements
            .where((element) => element['attribute'] == listName)
            .first['list'] as List<dynamic>? ??
        [];
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2)))),
      margin: const EdgeInsets.only(top: 0, bottom: 12, right: 6.0, left: 6.0),
      child: Wrap(
        runSpacing: 12.0,
        spacing: 12.0,
        children: items.map((e) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.star_purple500_rounded,
                color: Style.lavender,
                size: 10,
              ),
              Container(
                width: 6.0,
              ),
              CustomText(
                text:
                    '${names.where((element) => element['id'] == e).first[lang]}',
              )
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget info(
    String s1,
    String s2,
    double w,
  ) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.5)))),
      margin: EdgeInsets.symmetric(
          horizontal: _isDesktop! ? w * 0.05 : w * 0.15, vertical: 6),
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          CustomText(text: s1),
          const Spacer(),
          CustomText(
            textAlign: TextAlign.center,
            text: s2,
            weight: FontWeight.bold,
            color: Style.primaryColors,
          )
        ],
      ),
    );
  }
}
