import 'package:betna/setup/enumerators.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/popover/popover_notifications.dart';
import 'package:betna/style/popover/popover_region.dart';
import 'package:betna/style/responsive/screen_type_layout.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:betna/generated/l10n.dart';

class CustomBar extends StatefulWidget {
  const CustomBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomBar();
}

class _CustomBar extends State<CustomBar> {
  @override
  Widget build(BuildContext context) {
    return const ScreenTypeLayout(
      desktop: DesktopOrTablet(
        isTablet: false,
      ),
      tablet: DesktopOrTablet(
        isTablet: true,
      ),
    );
  }
}

class DesktopOrTablet extends StatelessWidget {
  final bool isTablet;

  const DesktopOrTablet({Key? key, required this.isTablet}) : super(key: key);

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
    Lang? lang = Provider.of<MainProvider>(context, listen: false).currentLang;
    Currency? kCurrency =
        Provider.of<MainProvider>(context, listen: true).currency;
    String logo = lang == Lang.AR
        ? 'assets/logo/logo_no_background_ar.png'
        : 'assets/logo/logo_no_background_en.png';
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        //top
        Container(
          height: 60,
          padding: EdgeInsets.symmetric(
              horizontal:
                  MediaQuery.of(context).size.width * (isTablet ? 0.05 : 0.19)),
          color: Style.lavenderBlack,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 48, vertical: 6),
                child: Image.asset(
                  logo,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(child: Row()),
              PopOverRegion.hoverWithClick(
                time: 1,
                child: const Icon(
                  Icons.language,
                  color: Colors.white,
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
              PopOverRegion.hoverWithClick(
                time: 1,
                child: const Icon(
                  Icons.currency_exchange,
                  color: Colors.white,
                ),
                clickPopChild: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...currency.map((gender) => GestureDetector(
                            child: Container(
                              width: 100,
                              height: 36,
                              color: kCurrency == gender['value']
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
                                  .changeCurrency(gender['value'], {});
                              if (kDebugMode) {
                                print(gender['value']);
                              }
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
                    text: S.of(context).kChangeCurrency,
                    size: 12,
                  ),
                ),
              )
            ],
          ),
        ),
        //social
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6))),
          height: 40,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...socials.map(
                (icon) => IconButton(
                  padding: EdgeInsets.all(6),
                  onPressed: () {},
                  icon: Icon(
                    icon['icon'],
                    size: 20,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
