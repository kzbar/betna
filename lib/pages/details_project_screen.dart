import 'package:betna/generated/l10n.dart';
import 'package:betna/models/project_model.dart';
import 'package:betna/services/firebase_collections_names.dart';
import 'package:betna/setup/general.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/setup/tools.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/popover/popover_controller.dart';
import 'package:betna/style/responsive/device_screen_type.dart';
import 'package:betna/style/responsive/responsive_builder.dart';
import 'package:betna/style/style.dart';
import 'package:betna/style/widget/ImageView.dart';
import 'package:betna/style/widget/hover_widget.dart';
import 'package:betna/style/widget/images_list.dart';
import 'package:betna/style/widget/images_page_view.dart';
import 'package:betna/style/widget/logo_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

class DetailsProject extends StatefulWidget {
  final ProjectModel? kModel;
  final String? tag;
  final bool fromUrl;
  final String? id;

  const DetailsProject(
      {Key? key, this.tag, this.kModel, required this.fromUrl, this.id})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailsProject();
}

class _DetailsProject extends State<DetailsProject> {
  ProjectModel? model;
  bool? _isDesktop;
  final translator = GoogleTranslator();
  final ScrollController _controller = ScrollController();
  bool scrollInTop = true;

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    if (!widget.fromUrl) {
      model = widget.kModel;
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
      return SafeArea(child: ResponsiveBuilder(
        builder: (context, size) {
          return PopOverController(
            child: Scaffold(
              backgroundColor: Colors.grey.shade200,
              // floatingActionButton: ContactNumber(),
              body: FutureBuilder(
                future: widget.fromUrl ? getAd() : Future.value(model),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
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
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: const Logo(
                                  withBackground: false,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.06,
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
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
                              ///IMAGE
                              Container(
                                color: Colors.transparent,
                                height: _isDesktop! ? h * 0.40 : h * 0.35,
                                child: Stack(
                                  children: [
                                    InkWell(
                                      child: Hero(
                                        tag: "${model!.id!}${widget.tag}",
                                        child: ImageView(
                                          fit: BoxFit.fill,
                                          image: model!.image![0],
                                          width: w,
                                          height:
                                              _isDesktop! ? h * 0.40 : h * 0.35,
                                        ),
                                      ),
                                      onTap: () {
                                        Get.to(() => ImagePageView(
                                              images: model!.image,
                                              tag: "${model!.id!}${model!.image![0]}",
                                            ));
                                      },
                                    ),
                                    Positioned(
                                        right: 6,
                                        top: 18,
                                        left: 6,
                                        child: Row(
                                          textDirection: TextDirection.rtl,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Get.to(() => ImagePageView(
                                                        images: model!.image,
                                                        tag:
                                                            "${model!.id!}${model!.image![0]}",
                                                      ));
                                                },
                                                icon: const Icon(
                                                  Icons.photo_library_rounded,
                                                  color: Colors.white,
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
                              /// in side image
                              if(model!.inSideImage != null && model!.inSideImage!.isNotEmpty)
                              Container(
                                height: 80,
                                alignment: Alignment.center,
                                child: ImageList(
                                  adId: model!.id!,
                                  photosList: model!.inSideImage,
                                ),
                              ),
                              ///TITLE
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 6, right: 6,top: 6,bottom: 6),
                                child: CustomText(
                                  size: 24,
                                  text: model!.title1[lang],
                                  textAlign: TextAlign.start,
                                ),
                              ),

                              Section(
                                widget: Container(
                                  alignment: Alignment.center,
                                  child: Wrap(
                                    runSpacing: 18.0,
                                    spacing: 18.0,
                                    alignment: WrapAlignment.center,
                                    runAlignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                    WrapCrossAlignment.center,
                                    children: [
                                      // Container(
                                      //   decoration:
                                      //       BoxDecoration(color: kPrimaryColor,borderRadius: Corners.lgBorder),
                                      //   width: 100,
                                      //   height: 60,
                                      //   child:                                                info(
                                      //       S.of(context).kDateAdded,
                                      //       intl.DateFormat("yyyy-MM-dd", 'en')
                                      //           .format(widget.model!.date!.toDate()),
                                      //       w),
                                      //
                                      //
                                      // ),
                                      Container(
                                        
                                        decoration: BoxDecoration(
                                            color: Style.primaryColors,
                                            borderRadius: Corners.lgBorder),
                                        padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                                        child: info(
                                            S.of(context).kCity,
                                            model!.city!.name!.toUpperCase(),
                                            w),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),

                                        decoration: BoxDecoration(
                                            color: Style.primaryColors,
                                            borderRadius: Corners.lgBorder),
                                        child: info(
                                            S.of(context).kNeighborhood,
                                            model!.town!.name!.toUpperCase(),
                                            w),
                                      ),

                                      Container(
                                        padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),

                                        decoration: BoxDecoration(
                                            color: Style.primaryColors,
                                            borderRadius: Corners.lgBorder),
                                        child: info(
                                            S.of(context).kConstructionYear,
                                            model!.constructionYear!,
                                            w),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),

                                        decoration: BoxDecoration(
                                            color: Style.primaryColors,
                                            borderRadius: Corners.lgBorder),
                                        child: info(S.of(context).kDeliveryDate,
                                            model!.deliveryDate!, w),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                                        margin: const EdgeInsets.symmetric(horizontal: 24),
                                        decoration: BoxDecoration(
                                            color: Style.primaryColors,
                                            borderRadius: Corners.lgBorder),
                                        child: info(
                                            S.of(context).kPriceStarts,
                                            Constants.convertPrice(
                                                context,
                                                model!.staredPrice!),
                                            w),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ///Explanation
                              Section(
                                title: S.of(context).kExplanation,
                                widget: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 14.0, vertical: 6.0),
                                  child: CustomText(
                                    text: model!.title2[lang],
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),

                              ///Payment Method
                              Section(
                                  title: S.of(context).kPaymentMethod,
                                  widget: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 14.0, vertical: 6.0),
                                    child: CustomText(
                                      text: model!.payment[lang],
                                      textAlign: TextAlign.start,
                                      letterSpacing: 1.0,
                                    ),
                                  )),
                              if (model!.roomsAndPrice!.isNotEmpty) ...[
                                Section(
                                  widget: Table(
                                    border: TableBorder.all(),
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    children: [
                                      TableRow(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              height: 36,
                                              child: CustomText(
                                                  text: S.of(context).kRoom),
                                            ),
                                            CustomText(
                                                text: S.of(context).kArea),
                                            CustomText(
                                                text:
                                                    S.of(context).kPriceStarts),
                                            CustomText(
                                                text: S.of(context).kBathrooms)
                                          ],
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              border: Border.all(
                                                  color: Colors.black))),
                                      ...model!.roomsAndPrice!.map((e) {
                                        dynamic item = e;
                                        return TableRow(children: [
                                          Container(
                                            height: 24,
                                            alignment: Alignment.center,
                                            child: CustomText(
                                              text: item['room'],
                                            ),
                                          ),
                                          CustomText(
                                            text: '${item['area']} m2',
                                          ),
                                          CustomText(

                                            text: Constants.convertPrice(
                                                context, item['price']),
                                            size: 10,
                                          ),
                                          CustomText(
                                            text: item['bath'],
                                          ),
                                        ]);
                                      }).toList()
                                    ],
                                  ),
                                  title: S.of(context).kRoom,
                                )
                              ],
                              if (model!.detailInformation!.isNotEmpty) ...[
                                Section(
                                  widget: Column(
                                    children: [
                                      ...List.generate(
                                          model!.detailInformation!.length,
                                          (index) {
                                        dynamic item =
                                            model!.detailInformation![index];
                                        return detailInformation(item[lang]);
                                      }),
                                    ],
                                  ),
                                  title: S.of(context).kDetailInformation,
                                )
                              ],

                              if (model!.externalFeatures!.isNotEmpty) ...[
                                Section(
                                  title: S.of(context).kExternalFeatures,
                                  widget: items(model!.externalFeatures!,
                                      'external_features', lang),
                                )
                              ],
                              if (model!.internalFeatures!.isNotEmpty) ...[
                                Section(
                                    title: S.of(context).kInternalFeatures,
                                    widget: items(model!.internalFeatures!,
                                        'internal_features', lang))
                              ],
                              if (model!.transportation!.isNotEmpty) ...[
                                Section(
                                  title: S.of(context).kTransportation,
                                  widget: items(model!.transportation!,
                                      'transportation', lang),
                                )
                              ],
                              if (model!.neighborhood!.isNotEmpty) ...[
                                Section(
                                  title: S.of(context).kNeighborhood,
                                  widget: items(model!.neighborhood!,
                                      'neighborhood', lang),
                                )
                              ],
                              if (model!.view!.isNotEmpty) ...[
                                Section(
                                  title: S.of(context).kView,
                                  widget: items(model!.view!, 'view', lang),
                                )
                              ],
                              const SizedBox(
                                height: 12,
                              ),

                              // Center(
                              //   child: SizedBox(
                              //     width: 200,
                              //     height: 60,
                              //     child: TextButton(
                              //         style: ButtonStyles.style,
                              //         onPressed: () {
                              //           //showBottomSheet(context);
                              //         },
                              //         child: CustomText(
                              //           color: Colors.white,
                              //           size: 16.0,
                              //           text: S.of(context).kTakeAppointment,
                              //         )),
                              //   ),
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
          );
        },
      ));
    });
  }

  Future<ProjectModel> getAd() async {
    if (widget.fromUrl) {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection(FirebaseCollectionNames.ProjectsCollection)
              .doc(widget.id)
              .get();
      setState(() {
        model = ProjectModel.fromJson(documentSnapshot.data()!);
      });
    } else {
      setState(() {
        model = widget.kModel;
      });
    }
    return Future.value(model);
  }

  // void showBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       routeSettings: RouteSettings(
  //           name: 'takeAppointment?reference=PROJECT_${widget.model!.id}'),
  //       backgroundColor: Colors.transparent,
  //       builder: (BuildContext context) {
  //         return TakeAppointment(
  //           reference: 'PROJECT_${widget.model!.id!}',
  //         );
  //       },
  //       context: context);
  // }

  _scrollListener() {
    if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
      setState(() {
        if (scrollInTop) {
          scrollInTop = false;
        }
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        scrollInTop = true;
      });
    }
  }

  Widget items(List items, String listName, String lang) {
    List names = forSaleElements
            .where((element) => element['attribute'] == listName)
            .first['list'] as List<dynamic>? ??
        [];
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      width: MediaQuery.of(context).size.width,
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
                color: Style.primaryColors,
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

  Widget detailInformation(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: Style.primaryColors,
            size: 16,
          ),
          CustomText(
            text: text,
            size: 16,
          )
        ],
      ),
    );
  }

  Widget info(
    String s1,
    String s2,
    double w,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: s1,
          size: 10,
          color: Colors.white70,
        ),
        const SizedBox(
          height: 6,
        ),
        CustomText(
          textAlign: TextAlign.center,
          text: s2,
          size: 10,
          weight: FontWeight.bold,
          color: Colors.white,
        )
      ],
    );
  }
}


class Section extends StatelessWidget {
  final Widget? widget;
  final String? title;

  const Section({Key? key, this.widget, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 2.0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Container(
                margin: const EdgeInsets.only(
                    top: 12, bottom: 6, right: 12, left: 12),
                child: CustomText(
                  text: title,
                  color: Style.primaryColors,
                  textAlign: TextAlign.start,
                  size: 16,
                ),
              ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: widget,
            ),
          ],
        ),
      ),
    );
  }
}
