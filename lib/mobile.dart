import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:betna/bar.dart';
import 'package:betna/generated/l10n.dart';
import 'package:betna/section/projects_section.dart';
import 'package:betna/section/resale_section.dart';
import 'package:betna/section/urgent_section.dart';
import 'package:betna/style/style.dart';
import 'package:betna/style/widget/list_view_items.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maker/widget/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

class MobilePage extends StatefulWidget {
  const MobilePage({super.key});

  @override
  State<StatefulWidget> createState() => _Mobile();
}

class _Mobile extends State<MobilePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  bool drawerIsOpen = false;
  static const List<Map> socials = [
    {
      'title': 'facebook',
      'icon': FontAwesomeIcons.facebook,
      'value': 'https://www.facebook.com/betnatr'
    },
    // {'title': 'twitter', 'icon': FontAwesomeIcons.twitter, 'value': 'https://'},
    {
      'title': 'instagram',
      'icon': FontAwesomeIcons.instagram,
      'value': 'https://www.instagram.com/betnatr/'
    },
    // {
    //   'title': 'telegram',
    //   'icon': FontAwesomeIcons.telegram,
    //   'value': 'https://'
    // },
    {
      'title': 'whatsapp',
      'icon': FontAwesomeIcons.whatsapp,
      'value': 'https://wa.me/message/WTBMCUW6NPAQA1'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Material(
      color: Colors.grey.shade300,
      child: Column(
        children: [
          const CustomBar(),
          const SizedBox(
            height: 3,
          ),
          Expanded(
              child: Scaffold(
            backgroundColor: Colors.grey.shade300,
            key: _key,
            body: Column(
              children: [
                Expanded(
                    child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ///title
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1),
                              color: Style.primaryColors.withOpacity(0.075)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 12,right: 12,top: 6),
                                child: SizedBox(
                                  height: 40,
                                  child: DefaultTextStyle(
                                    style:  const TextStyle(
                                      fontFamily: 'LBC',
                                      fontSize: 24,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 8.0,
                                          color: Colors.white,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: AnimatedTextKit(
                                      repeatForever: true,
                                      animatedTexts: [
                                        FlickerAnimatedText(S.of(context).kUrgent),
                                        FlickerAnimatedText(S.of(context).kUrgent1),
                                        FlickerAnimatedText(S.of(context).kUrgent2),
                                      ],
                                      onTap: () {
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                width: MediaQuery.of(context).size.width * 0.95,
                                height: 200,
                                child: const UrgentListWidget(),
                              ),
                            ],
                          ),
                        ),
                        ///resale list
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: ListViewItems(
                            title: S.of(context).kSale,
                            titleAction: S.of(context).kSeeAllListing,
                            function: () {},
                            list: const SaleListWidget(),
                          ),
                        ),
                        ///projects list
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: ListViewItems(
                            title: S.of(context).kProjectAll,
                            titleAction: S.of(context).kSeeAllListing,
                            function: () {},
                            list: const ProjectsListWidget(),
                          ),
                        ),

                      ],
                    ),
                  ),
                )),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Style.lavenderBlack,
                      ),
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ...socials.map(
                            (icon) => IconButton(
                              padding: const EdgeInsets.all(10),
                              onPressed: () {
                                launchURL(icon['value'], context);
                              },
                              icon: Icon(
                                icon['icon'],
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    ));
  }

  launchURL(data, context) async {
    try {
      await launchUrl(Uri.parse(data));
    } catch (error) {}
  }

  _launchInstagram() async {
    const nativeUrl = "instagram://user?betnatr=severinas_app";
    const webUrl = "https://www.instagram.com/betnatr/";
    if (await canLaunchUrl(Uri.parse(nativeUrl))) {
      await launchUrl(Uri.parse(nativeUrl));
    } else if (await canLaunchUrl(Uri.parse(webUrl))) {
      await launchUrl(Uri.parse(webUrl));
    } else {
      print("can't open Instagram");
    }
  }
}
