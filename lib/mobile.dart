
import 'package:betna/bar.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MobilePage extends StatefulWidget {
  const MobilePage({super.key});

  @override
  State<StatefulWidget> createState() => _Mobile();

}


class _Mobile extends State<MobilePage>{
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  bool drawerIsOpen = false;
  static const List<Map> socials = [
    {
      'title': 'facebook',
      'icon': FontAwesomeIcons.facebook,
      'value': 'https://'
    },
    {'title': 'twitter', 'icon': FontAwesomeIcons.twitter, 'value': 'https://'},
    {
      'title': 'instagram',
      'icon': FontAwesomeIcons.instagram,
      'value': 'https://'
    },
    {
      'title': 'telegram',
      'icon': FontAwesomeIcons.telegram,
      'value': 'https://'
    },
    {
      'title': 'whatsapp',
      'icon': FontAwesomeIcons.whatsapp,
      'value': 'https://'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const CustomBar(),
          Divider(color: Colors.green.shade50,),
          Expanded(child: Scaffold(
            key: _key,
            body: Column(
              children: [
                Expanded(child: SingleChildScrollView()),
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
                              onPressed: () {},
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
    );
  }

}