import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:betna/bar.dart';
import 'package:betna/generated/l10n.dart';
import 'package:betna/section/projects_section.dart';
import 'package:betna/section/resale_section.dart';
import 'package:betna/section/urgent_section.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/widget/hover_icon.dart';
import 'package:betna/style/widget/list_view_items.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Desktop extends StatefulWidget {
  const Desktop({super.key});

  @override
  State<StatefulWidget> createState() => _Desktop();
}

class _Desktop extends State<Desktop> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const CustomBar(),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1)),
          Expanded(
              child: SizedBox(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///Urgent List
                  Container(
                    padding:
                        const EdgeInsets.only(left: 48, right: 48, bottom: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: Style.primaryColors.withOpacity(0.075)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 6),
                          child: SizedBox(
                            height: 40,
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                fontSize: 24,
                                fontFamily: 'LBC',
                                color: Colors.black,
                                shadows: [
                                  Shadow(
                                    blurRadius: 8.0,
                                    color: Colors.grey,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: AnimatedTextKit(
                                repeatForever: true,
                                animatedTexts: [
                                  FlickerAnimatedText(S.of(context).kUrgent,
                                      textAlign: TextAlign.center),
                                  FlickerAnimatedText(S.of(context).kUrgent1),
                                  FlickerAnimatedText(S.of(context).kUrgent2),
                                ],
                                onTap: () {},
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          width: w,
                          height: 200,
                          child: const UrgentListWidget(),
                        ),
                      ],
                    ),
                  ),

                  ///resale list
                  ListViewItems(
                    title: S.of(context).kSale,
                    titleAction: S.of(context).kSeeAllListing,
                    function: () {},
                    list: const SaleListWidget(),
                  ),

                  ///projects list
                  ListViewItems(
                    title: S.of(context).kProjectAll,
                    titleAction: S.of(context).kSeeAllListing,
                    function: () {},
                    list: const ProjectsListWidget(),
                  ),

                  ///bottom
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: w,
                    color: Style.lavenderBlack,
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 12,
                          left: MediaQuery.of(context).size.width * 0.25,
                          right: MediaQuery.of(context).size.width * 0.25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: TextDirection.ltr,
                        children: [
                          CustomText(
                            text: S.of(context).kCommunication,
                            size: 24,
                            color: Colors.white,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.ltr,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                textDirection: TextDirection.ltr,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      launchURL(
                                          'https://www.instagram.com/betnatr/',
                                          context);
                                    },
                                    child: Row(
                                      textDirection: TextDirection.ltr,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        HoverIcon(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 6),
                                          data: FontAwesomeIcons.instagram,
                                          backgroundColor: Colors.white,
                                          backgroundColorHover: Style.lavender,
                                        ),
                                        CustomText(
                                          text: 'betnatr',
                                          height: 2.5,
                                          size: 18,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      launchURL(
                                          'https://www.facebook.com/betnatr',
                                          context);
                                    },
                                    child: Row(
                                      textDirection: TextDirection.ltr,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        HoverIcon(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 6),
                                          data: FontAwesomeIcons.facebook,
                                          backgroundColor: Colors.white,
                                          backgroundColorHover: Style.lavender,
                                        ),
                                        CustomText(
                                          text: 'betnatr',
                                          size: 18,
                                          height: 2.5,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                textDirection: TextDirection.ltr,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    textDirection: TextDirection.ltr,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            launchURL(
                                                'tel:+905525333666', context);
                                          },
                                          child: HoverIcon(
                                            data: FontAwesomeIcons.squarePhone,
                                            backgroundColor: Colors.white,
                                            backgroundColorHover:
                                                Style.lavender,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 6),
                                          )),
                                      CustomText(
                                        text: '+905525333666',
                                        size: 18,
                                        height: 2.5,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                  Row(
                                    textDirection: TextDirection.ltr,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        child: HoverIcon(
                                          data: FontAwesomeIcons.map,
                                          backgroundColor: Colors.white,
                                          backgroundColorHover: Style.lavender,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 6),
                                        ),
                                        onTap: () {
                                          launchURL(
                                              'https://goo.gl/maps/HxS2xERY25sdud7b6',
                                              context);
                                        },
                                      ),
                                      Container(
                                        width: 200,
                                        child: CustomText(
                                          text:
                                              'FATİH MA. DOĞAN ARASLI BLV. NO:123. KAT:2 . OFİS:13 İSTANBUL ESENYURT',
                                          size: 12,
                                          textAlign: TextAlign.start,
                                          textDirection: TextDirection.ltr,
                                          weight: FontWeight.bold,
                                          height: 1.5,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.002,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  launchURL(data, context) async {
    try {
      await launchUrl(Uri.parse(data));
    } catch (error) {}
  }
}
