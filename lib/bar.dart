import 'package:betna/setup/enumerators.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/popover/popover_notifications.dart';
import 'package:betna/style/popover/popover_region.dart';
import 'package:betna/style/responsive/screen_type_layout.dart';
import 'package:betna/style/style.dart';
import 'package:betna/style/widget/currency_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:betna/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomBar extends StatefulWidget {
  const CustomBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomBar();
}

class _CustomBar extends State<CustomBar> with TickerProviderStateMixin {
  late AnimationController? animationIconController1;

  _CustomBar();

  @override
  void initState() {
    super.initState();
    animationIconController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
      reverseDuration: const Duration(milliseconds: 750),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: DesktopOrTablet(
        isTablet: false,
      ),
      tablet: DesktopOrTablet(
        isTablet: true,
      ),
      mobile: Mobile(
        controller: animationIconController1,
      ),
    );
  }
}
class DesktopOrTablet extends StatelessWidget {
  final bool isTablet;

  DesktopOrTablet({Key? key, required this.isTablet}) : super(key: key);

  static const List<Map> langs = [
    {'title': 'English', 'value': Lang.EN},
    {'title': 'Arabic', 'value': Lang.AR},
    {'title': 'Turkish', 'value': Lang.TR}
  ];
  static const List<Map> currency = [
    {'title': 'TRY', 'value': Currency.TRY},
    {'title': 'USD', 'value': Currency.USD},
    {'title': 'EUR', 'value': Currency.EUR},
    {'title': 'SAR', 'value': Currency.SAR},
    {'title': 'AED', 'value': Currency.AED}
  ];
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
      'value': 'https://www.instagram.com/betnatr'
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
  late Map? map;

  @override
  Widget build(BuildContext context) {
    Lang? lang = Provider.of<MainProvider>(context, listen: false).currentLang;

    String logo;
    switch (lang) {
      case Lang.AR:
        logo = 'assets/logo/logoAR.png';
        break;
      case Lang.EN:
        logo = 'assets/logo/logoEn.png';
        break;
      case Lang.TR:
        logo = 'assets/logo/logoTR.png';
        break;
      default:
        {
          logo = 'assets/logo/logoEn.png';
        }
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          color: Style.lavenderBlack,
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.25),
          child: Row(
            children: [
              PopOverRegion.click(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Style.lavenderBlack,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6))),
                    height: 48,
                    child: CustomText(
                      text: '+90 5525 333 666',
                      color: Colors.white,
                      size: 28,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  popChild: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    color: Style.lavenderBlack,
                    height: 40,
                    width: 190,
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            _launchUrl(Uri.parse(
                                'https://wa.me/message/WTBMCUW6NPAQA1'));
                          },
                          child: CustomText(
                            text: S.of(context).kWhatsApp,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            _launchUrl(Uri.parse('tel:+905525333666'));
                          },
                          child: CustomText(
                            text: S.of(context).kCallNow,
                            color: Colors.white,
                            size: 12,
                          ),
                        )
                      ],
                    ),
                  )),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: Style.lavenderBlack,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6))),
                height: 40,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...socials.map(
                      (icon) => IconButton(
                        padding: const EdgeInsets.all(6),
                        onPressed: () {
                          _launchUrl(Uri.parse(icon['value']));
                        },
                        icon: Icon(
                          icon['icon'],
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 80,
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0, 1))]),
          padding: EdgeInsets.symmetric(
              horizontal:
                  MediaQuery.of(context).size.width * (isTablet ? 0.05 : 0.19)),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 6),
                child: Image.asset(
                  logo,
                  width: 250,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(child: Row()),
              PopOverRegion.hoverWithClick(
                time: 1,
                child: Icon(
                  Icons.language,
                  color: Style.lavenderBlack,
                  size: 30,
                ),
                clickPopChild: Card(
                  child: Column(
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
                                color: Colors.black,
                                size: 16,
                                height: 1,
                              ),
                            ),
                            onTap: () async {
                              await Provider.of<MainProvider>(context,
                                      listen: false)
                                  .changeCurrentLang(gender['value']);
                              // ignore: use_build_context_synchronously
                              ClosePopoverNotification().dispatch(context);
                            },
                          ))
                    ],
                  ),
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
              const Padding(padding: EdgeInsets.all(12)),
              const CurrencyWidget()
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}

class Mobile extends StatelessWidget {
  final AnimationController? controller;

  const Mobile({
    Key? key,
    this.controller,
  }) : super(key: key);

  static const List<Map> langs = [
    {'title': 'English', 'value': Lang.EN},
    {'title': 'Arabic', 'value': Lang.AR},
    {'title': 'Turkish', 'value': Lang.TR}
  ];
  static const List<Map> currency = [
    {'title': 'TRY', 'value': Currency.TRY},
    {'title': 'USD', 'value': Currency.USD},
    {'title': 'EUR', 'value': Currency.EUR},
    {'title': 'SAR', 'value': Currency.SAR},
    {'title': 'AED', 'value': Currency.AED}
  ];
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
      'value': 'https://www.instagram.com/betnatr'
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
    String logo;
    switch (lang) {
      case Lang.AR:
        logo = 'assets/logo/logoAR.png';
        break;
      case Lang.EN:
        logo = 'assets/logo/logoEn.png';
        break;
      case Lang.TR:
        logo = 'assets/logo/logoTR.png';
        break;
      default:
        {
          logo = 'assets/logo/logoEe.png';
        }
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        //top
        Container(
          height: 80,
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0, 1))]),
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 6),
                child: Image.asset(
                  logo,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(child: Row()),
              PopOverRegion.hoverWithClick(
                time: 1,
                child: Icon(
                  Icons.language,
                  color: Style.lavenderBlack,
                ),
                clickPopChild: Card(
                  child: Column(
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
                                color: Colors.black,
                                size: 16,
                                height: 1,
                              ),
                            ),
                            onTap: () async {
                              await Provider.of<MainProvider>(context,
                                      listen: false)
                                  .changeCurrentLang(gender['value']);
                              // ignore: use_build_context_synchronously
                              ClosePopoverNotification().dispatch(context);
                            },
                          ))
                    ],
                  ),
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
              const Padding(padding: EdgeInsets.all(12)),
              const CurrencyWidget()
            ],
          ),
        ),
      ],
    );
  }
}
