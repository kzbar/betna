import 'package:betna/bar.dart';
import 'package:betna/section/projects_section.dart';
import 'package:betna/section/sale_section_.dart';
import 'package:betna/section/urgent_section.dart';
import 'package:betna/setup/enumerators.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/style/style.dart';
import 'package:betna/style/widget/about_as.dart';
import 'package:betna/style/widget/note_exchange_rate.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
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
    Lang? lang = Provider.of<MainProvider>(context, listen: false).currentLang;

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
                ///main
                Expanded(
                    child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: SingleChildScrollView(
                    child: Column(
                      children:  [
                        const NoteExchangeRate(edgeInsetsGeometry: EdgeInsets.symmetric(horizontal: 12),textSize: 8,),

                        const UrgentSection(),

                        ///resale list
                        const NewSaleSection(),


                        ///projects list
                        const ProjectsSection(),

                        ///about us
                        AboutAs(edgeInsetsGeometry: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25, bottom: 24),textSize: 10,),

                      ],
                    ),
                  ),
                )),

                /// contact
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
                                // ChatGPT().result().then((value) {
                                //   print(value!.choices[0].text);
                                // });
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
}
