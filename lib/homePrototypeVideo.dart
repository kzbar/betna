import 'package:betna/services/firebase_collections_names.dart';
import 'package:betna/setup/enumerators.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/main_app_scaffold.dart';
import 'package:betna/style/popover/popover_notifications.dart';
import 'package:betna/style/popover/popover_region.dart';
import 'package:betna/style/responsive/screen_type_layout.dart';
import 'package:betna/style/style.dart';
import 'package:betna/style/widget/ImageView.dart';
import 'package:betna/style/widget/hover_icon.dart';
import 'package:betna/style/widget/hover_widget.dart';
import 'package:betna/style/widget/logo_widget.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import 'generated/l10n.dart';
import 'models/header_page_model.dart';

class HomePrototypeVideo extends StatefulWidget {
  const HomePrototypeVideo({super.key});

  @override
  State<StatefulWidget> createState() => _HomePrototypeVideo();
}

class _HomePrototypeVideo extends State<HomePrototypeVideo> {
  late VideoPlayerController _controller;
  static const List<Map> langs = [
    {'title': 'Turkish', 'value': Lang.TR},
    {'title': 'English', 'value': Lang.EN},
    {'title': 'Arabic', 'value': Lang.AR},

  ];
  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        "https://firebasestorage.googleapis.com/v0/b/kira-contract.appspot.com/o/Blue%20Digital%20Website%20New%20Features%20Announcement%20Video.mp4?alt=media&token=69f6cea0-a960-49d7-9405-9e4dc6720ce3"))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        //_controller.setLooping(true);
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Lang? lang = Provider.of<MainProvider>(context, listen: false).currentLang;
    if (kDebugMode) {
      print(MediaQuery.of(context).size.width);
    }
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MainAppScaffold(
      child: ScreenTypeLayout(
        desktop: Stack(
          fit: StackFit.expand,
          children: [
            const Positioned.fill(child: Pages()),
            Positioned.directional(
                width: width * 0.765,
                end: 0.0,
                height: height * 0.06,
                top: 0,
                textDirection:
                    lang == Lang.AR ? TextDirection.rtl : TextDirection.ltr,
                child: CustomPaint(
                  painter: Bar(angle: 0.007, lang: lang!),
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 6,
                      bottom: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 12,
                        ),
                        const Logo(
                          withBackground: true,
                          hi: 100,
                          we: 150,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            launchURL('https://betnagayrimenkul.sahibinden.com',
                                context);
                          },
                          child: HoverWidget(
                            width: 200,
                            widget: CustomText(
                              text: S.of(context).kSeeAllListing,
                              weight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            backgroundColor: Colors.white.withOpacity(0.2),
                            backgroundColorHover: Style.primaryColors,
                            borderRadius: 3,
                          ),
                        ),
                        const Spacer(),
                        PopOverRegion.hoverWithClick(
                          time: 1,
                          child: Icon(
                            FontAwesomeIcons.language,
                            color: Style.lavenderBlack,
                            size: 24,
                          ),
                          clickPopChild: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...langs.map((gender) => GestureDetector(
                                    child: Container(
                                      width: 100,
                                      height: 36,
                                      color: lang == gender['value']
                                          ? Colors.black26
                                          : Colors.transparent,
                                      alignment: Alignment.center,
                                      child: CustomText(
                                        text: gender['title'],
                                        color: Colors.white,
                                        weight: FontWeight.bold,
                                        size: 16,
                                        height: 1,
                                      ),
                                    ),
                                    onTap: () async {
                                      ClosePopoverNotification()
                                          .dispatch(context);
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .changeCurrentLang(gender['value']);
                                      // ignore: use_build_context_synchronously
                                    },
                                  ))
                            ],
                          ),
                          hoverPopChild: Container(
                            padding: const EdgeInsets.all(6.0),
                            color: Colors.black12,
                            margin: const EdgeInsets.all(12),
                            child: CustomText(
                              text: S.of(context).kChangeLang,
                              size: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 48,
                        )
                      ],
                    ),
                  ),
                )),
            Positioned.directional(
                bottom: 0,
                end: 0.0,
                width: width * 0.85,
                height: height * 0.05,
                textDirection:
                    lang == Lang.AR ? TextDirection.rtl : TextDirection.ltr,
                child: CustomPaint(
                  painter: Bar(angle: 0.005, lang: lang!),
                  child: Container(
                    padding: EdgeInsets.only(top: 6, bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      textDirection: TextDirection.ltr,
                      children: [
                        GestureDetector(
                          onTap: () {
                            launchURL(
                                'https://www.instagram.com/betnatr/', context);
                          },
                          child: HoverIcon(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            data: FontAwesomeIcons.instagram,
                            backgroundColor: Style.lavenderBlack,
                            backgroundColorHover: Style.primaryColors,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        GestureDetector(
                          onTap: () {
                            launchURL(
                                'https://www.facebook.com/betnatr', context);
                          },
                          child: HoverIcon(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            data: FontAwesomeIcons.facebook,
                            backgroundColor: Style.lavenderBlack,
                            backgroundColorHover: Style.primaryColors,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                            onTap: () {
                              launchURL('tel:+905525333666', context);
                            },
                            child: HoverIcon(
                              data: FontAwesomeIcons.squarePhone,
                              backgroundColor: Style.lavenderBlack,
                              backgroundColorHover: Style.primaryColors,
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                            )),
                        const SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          child: HoverIcon(
                            data: FontAwesomeIcons.mapLocation,
                            backgroundColor: Style.lavenderBlack,
                            backgroundColorHover: Style.primaryColors,
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                          ),
                          onTap: () {
                            launchURL(
                                'https://maps.app.goo.gl/Wxs5H48VPuHjc7Hk7',
                                context);
                          },
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
        mobile: Stack(
          fit: StackFit.expand,
          children: [
            const Positioned.fill(child: Pages(width: 0.75)),
            Positioned.directional(
                width: width * 1,
                end: 0.0,
                height: height * 0.07,
                top: 0,
                textDirection:
                lang == Lang.AR ? TextDirection.rtl : TextDirection.ltr,
                child: CustomPaint(
                  painter: Bar(angle: 0.000, lang: lang!),
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 6,
                      bottom: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 6,
                        ),
                        const Logo(
                          withBackground: true,
                          hi: 50,
                          we: 75,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            launchURL('https://betnagayrimenkul.sahibinden.com',
                                context);
                          },
                          child: HoverWidget(
                            width: 100,
                            widget: CustomText(
                              text: S.of(context).kSeeAllListing,
                              weight: FontWeight.bold,
                              color: Colors.black,
                              size: 6,
                            ),
                            backgroundColor: Colors.white.withOpacity(0.2),
                            backgroundColorHover: Style.primaryColors,
                            borderRadius: 3,
                          ),
                        ),
                        const Spacer(),
                        PopOverRegion.hoverWithClick(
                          time: 1,
                          child: Icon(
                            FontAwesomeIcons.language,
                            color: Style.lavenderBlack,
                            size: 12,
                          ),
                          clickPopChild: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...langs.map((gender) => GestureDetector(
                                child: Container(
                                  width: 100,
                                  height: 36,
                                  color: lang == gender['value']
                                      ? Colors.black26
                                      : Colors.transparent,
                                  alignment: Alignment.center,
                                  child: CustomText(
                                    text: gender['title'],
                                    color: Colors.white,
                                    weight: FontWeight.bold,
                                    size: 12,
                                    height: 1,
                                  ),
                                ),
                                onTap: () async {
                                  ClosePopoverNotification()
                                      .dispatch(context);
                                  Provider.of<MainProvider>(context,
                                      listen: false)
                                      .changeCurrentLang(gender['value']);
                                  // ignore: use_build_context_synchronously
                                },
                              ))
                            ],
                          ),
                          hoverPopChild: Container(
                            padding: const EdgeInsets.all(6.0),
                            color: Colors.black12,
                            margin: const EdgeInsets.all(6),
                            child: CustomText(
                              text: S.of(context).kChangeLang,
                              size: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        )
                      ],
                    ),
                  ),
                )),
            Positioned.directional(
                bottom: 0,
                end: 0.0,
                width: width * 1,
                height: height * 0.07,
                textDirection:
                lang == Lang.AR ? TextDirection.rtl : TextDirection.ltr,
                child: CustomPaint(
                  painter: Bar(angle: 0.000, lang: lang!),
                  child: Container(
                    padding: EdgeInsets.only(top: 6, bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      textDirection: TextDirection.ltr,
                      children: [
                        GestureDetector(
                          onTap: () {
                            launchURL(
                                'https://www.instagram.com/betnatr/', context);
                          },
                          child: HoverIcon(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            size: 12,
                            data: FontAwesomeIcons.instagram,
                            backgroundColor: Style.lavenderBlack,
                            backgroundColorHover: Style.primaryColors,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        GestureDetector(
                          onTap: () {
                            launchURL(
                                'https://www.facebook.com/betnatr', context);
                          },
                          child: HoverIcon(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            data: FontAwesomeIcons.facebook,
                            size: 12,
                            backgroundColor: Style.lavenderBlack,
                            backgroundColorHover: Style.primaryColors,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        GestureDetector(
                            onTap: () {
                              launchURL('tel:+905525333666', context);
                            },
                            child: HoverIcon(
                              data: FontAwesomeIcons.squarePhone,
                              backgroundColor: Style.lavenderBlack,
                              backgroundColorHover: Style.primaryColors,
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              size: 12,
                            )),
                        const SizedBox(
                          width: 6,
                        ),
                        GestureDetector(
                          child: HoverIcon(
                            data: FontAwesomeIcons.mapLocation,
                            backgroundColor: Style.lavenderBlack,
                            backgroundColorHover: Style.primaryColors,
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            size: 12,
                          ),
                          onTap: () {
                            launchURL(
                                'https://maps.app.goo.gl/Wxs5H48VPuHjc7Hk7',
                                context);
                          },
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  launchURL(data, context) async {
    try {
      await launchUrl(Uri.parse(data));
    } catch (error) {}
  }
}

class LinePainter extends CustomPainter {
  final Color clr;

  LinePainter({this.clr = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = clr
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
    // Draw a line from top-left to bottom-right
    canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class Pages extends StatefulWidget {
  const Pages({super.key, this.width = 0.38});
  final double width ;


  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    Lang? lang = Provider.of<MainProvider>(context, listen: false).currentLang;

    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection(FirebaseCollectionNames.prototypeImagesPageCollection)
          .get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return CarouselSlider.builder(
            carouselController: buttonCarouselController,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
              HeaderPageModel model = HeaderPageModel.fromJson(
                  snapshot.data!.docs[itemIndex].data()
                      as Map<String, dynamic>);
              Widget imageItem = Stack(
                children: [
                  Opacity(
                    opacity: 0.9,
                    child: ImageView(image: model.imageUrl,loading: true,width:double.infinity,height: double.infinity,),
                  ),
                  Positioned.directional(
                      width:
                          MediaQueryData.fromView(View.of(context)).size.width *
                              widget.width,
                      top: 0,
                      bottom: 0,
                      textDirection: TextDirection.ltr,
                      child: CustomPaint(
                        painter: lang! == Lang.AR
                            ? RealEstatePainterAR()
                            : RealEstatePainter(),
                        child: Container(
                          alignment: lang == Lang.AR
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQueryData.fromView(View.of(context))
                                        .size
                                        .width *
                                    widget.width /
                                    2.5,
                                child: CustomText(
                                  text: model.title[lang!.name.toLowerCase()],
                                  color: Colors.white,
                                  size: 24,
                                  weight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 12, bottom: 12),
                                child: CustomPaint(
                                  painter: LinePainter(),
                                ),
                                width: MediaQueryData.fromView(View.of(context))
                                        .size
                                        .width *
                                    0.1,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 6, right: 6),
                                width: MediaQueryData.fromView(View.of(context))
                                        .size
                                        .width *
                                    widget.width/
                                    2.5,
                                child: CustomText(
                                  text:model.title2[lang!.name.toLowerCase()],
                                  color: Colors.white,
                                  size: 12,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              );
              return model.type == "img" ? imageItem : Container();
            },
            options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                viewportFraction: 1,
                autoPlay: true),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class RealEstatePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // الخلفية
    final backgroundPaint = Paint()
      ..color = Style.primaryColors.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final backgroundPath = Path();
    backgroundPath.moveTo(0, 0);
    backgroundPath.lineTo(size.width * 0.618, 0);
    backgroundPath.lineTo(size.width * 0.38, size.height);
    backgroundPath.lineTo(0, size.height);
    //backgroundPath.lineTo(0, size.height * 0.85);
    backgroundPath.close();

    canvas.drawPath(backgroundPath, backgroundPaint);

    ///
    // الشكل المائل الإضافي
    final overlayPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final overlayPath = Path();
    overlayPath.moveTo(size.width * 0.623, 0);
    overlayPath.lineTo(size.width * 0.625, 0);
    overlayPath.lineTo(size.width * 0.388, size.height);
    overlayPath.lineTo(size.width * 0.385, size.height);

    overlayPath.close();

    canvas.drawPath(overlayPath, overlayPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class RealEstatePainterAR extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // الخلفية
    final backgroundPaint = Paint()
      ..color = Style.primaryColors.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final backgroundPath = Path();
    backgroundPath.moveTo(size.width, 0);

    backgroundPath.lineTo(size.width * 0.38, 0);
    backgroundPath.lineTo(size.width * 0.618, size.height);
    backgroundPath.lineTo(size.width, size.height);

    backgroundPath.close();
    canvas.drawPath(backgroundPath, backgroundPaint);

    ///
    // الشكل المائل الإضافي
    final overlayPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final overlayPath = Path();

    overlayPath.moveTo(size.width * 0.374, 0);
    overlayPath.lineTo(size.width * 0.377, 0);
    overlayPath.lineTo(size.width * 0.615, size.height);
    overlayPath.lineTo(size.width * 0.612, size.height);

    overlayPath.close();

    canvas.drawPath(overlayPath, overlayPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class Bar extends CustomPainter {
  final Lang lang;
  final double angle;

  Bar({this.angle = 0.009000, this.lang = Lang.EN});

  @override
  void paint(Canvas canvas, Size size) {
    // الخلفية
    final backgroundPaint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    if (lang == Lang.EN || lang == Lang.TR) {
      final backgroundPath = Path();
      backgroundPath.moveTo(size.width * angle, 0);
      backgroundPath.lineTo(size.width, 0);
      backgroundPath.lineTo(size.width, size.height);
      backgroundPath.lineTo(size.width * 0.0000100, size.height);
      backgroundPath.close();
      canvas.drawPath(backgroundPath, backgroundPaint);
    } else {
      final backgroundPath = Path();
      backgroundPath.moveTo(0, 0);
      backgroundPath.lineTo(size.width - size.width * angle, 0);
      backgroundPath.lineTo(size.width, size.height);
      backgroundPath.lineTo(0, size.height);
      backgroundPath.close();
      canvas.drawPath(backgroundPath, backgroundPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
