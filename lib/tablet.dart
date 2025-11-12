import 'package:betna/bar.dart';
import 'package:betna/generated/l10n.dart';
import 'package:betna/section/projects_section.dart';
import 'package:betna/section/sale_section_.dart';
import 'package:betna/section/urgent_section.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/widget/about_as.dart';
import 'package:betna/style/widget/hover_icon.dart';
import 'package:betna/style/style.dart';
import 'package:betna/style/widget/note_exchange_rate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Tablet extends StatefulWidget {
  const Tablet({super.key});

  @override
  State<StatefulWidget> createState() => _Tablet();
}

class _Tablet extends State<Tablet> {
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
                      const NoteExchangeRate(edgeInsetsGeometry: EdgeInsets.symmetric(horizontal: 100),textSize: 12,),
                      ///Urgent List
                      const UrgentSection(),
                      ///resale list
                      const NewSaleSection(),
                      ///projects list
                      const ProjectsSection(),
                      ///about us
                      AboutAs(edgeInsetsGeometry: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.25,
                          bottom: 24,
                          right: MediaQuery.of(context).size.width * 0.09,
                          left: MediaQuery.of(context).size.width * 0.09),textSize: 14,),
                      ///bottom
                      Container(
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: w,
                        color: Style.lavenderBlack,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 12,
                              left: MediaQuery.of(context).size.width * 0.10,
                              right: MediaQuery.of(context).size.width * 0.10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textDirection: TextDirection.ltr,
                            children: [
                              CustomText(
                                text: S.of(context).kCommunication,
                                size: 24,
                                color: Colors.white,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                      const SizedBox(
                                        width: 6,
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
                                      const SizedBox(
                                        width: 6,
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
                                              size: 10,
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
