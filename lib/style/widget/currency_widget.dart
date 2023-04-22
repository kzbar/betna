
import 'package:betna/setup/enumerators.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/popover/popover_region.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../popover/popover_notifications.dart';

class CurrencyWidget extends StatefulWidget {
  final Alignment? alignmentAR;
  final Alignment? alignmentEN;
  final bool? withName;

  const CurrencyWidget(
      {Key? key,
      this.alignmentAR = Alignment.topCenter,
      this.alignmentEN = Alignment.topCenter,
      this.withName = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CurrencyWidget();
  }
}

class _CurrencyWidget extends State<CurrencyWidget> {
  Map? map;

  @override
  Widget build(BuildContext context) {
    List<dynamic> list =
        Provider.of<MainProvider>(context, listen: true).currencyList;
    map = Provider.of<MainProvider>(context, listen: true).currencyMap;
    var initData = map ??
        (list.isNotEmpty
            ? list.where((element) => element.id == 'TRY').first.data()
            : null);
    void _handleSharePressed(Map map) {
      String? shortName = map['short_name'];
      Currency? currency;
      if (shortName == 'TRY') {
        currency = Currency.TRY;
      } else if (shortName == 'USD') {
        currency = Currency.USD;
      } else if (shortName == 'EUR') {
        currency = Currency.EUR;
      } else if (shortName == 'SAR') {
        currency = Currency.SAR;
      } else if (shortName == 'KWD') {
        currency = Currency.KWD;
      } else if (shortName == 'QAR') {
        currency = Currency.QAR;
      } else if (shortName == 'IQD') {
        currency = Currency.IQD;
      } else if (shortName == 'GBP') {
        currency = Currency.GBP;
      } else if (shortName == 'JOD') {
        currency = Currency.JOD;
      } else if (shortName == 'AED') {
        currency = Currency.AED;
      } else if (shortName == 'YER') {
        currency = Currency.YER;
      } else if (shortName == 'LYD') {
        currency = Currency.LYD;
      } else if (shortName == 'AED') {
        currency = Currency.AED;
      }
      Provider.of<MainProvider>(context, listen: false)
          .changeCurrency(currency, map);

      setState(() {
        this.map = map;
      });
      ClosePopoverNotification().dispatch(context);
    }

    return list.isNotEmpty
        ? PopOverRegion.click(
            child: initData != null
                ? GestureDetector(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      child: Container(
                        // width: widget.withName! ? 60 : 30,
                        alignment: Alignment.center,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.currency_exchange,
                              color: Style.lavenderBlack,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Container(
                              padding: EdgeInsets.all(3),

                              child: ClipOval(
                                child: Image.asset(
                                  'assets/flags/${initData['short_name']}.png',
                                  height: 24,
                                  width: 24,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            if (widget.withName!) ...[
                              // CustomText(
                              //   text: '${initData['short_name']}',
                              //   size: 14.0,
                              //   height: 2,
                              // )
                            ],
                            CustomText(
                              text: '${initData['symbol']}',
                              size: 8,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
            popChild: Card(
              color: Colors.white70,
              child: SizedBox(
                width: 200,
                child: Wrap(
                  children: list
                      .where((element) => element.data()['price'] != null)
                      .map((e) {
                    var initData = e.data();
                    final Widget networkSvg = SvgPicture.string(
                      initData['svg'],
                      fit: BoxFit.fill,
                    );

                    return InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            color: map != null
                                ? map!['short_name'] == initData['short_name']
                                    ? Style.lavender
                                    : Colors.transparent
                                : Colors.transparent,
                            borderRadius: Corners.medBorder),
                        width: 80,
                        margin: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 6.0),
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white)),
                              width: 24,
                              height: 24,
                              child: ClipOval(
                                child: networkSvg,
                              ),
                            ),
                            Expanded(
                              child: CustomText(
                                text: '${initData['short_name']} ',
                                size: 16,
                              ),
                            ) // CustomText(text: '${initData['symbol']}',size: 8,)
                          ],
                        ),
                      ),
                      onTap: () {
                        _handleSharePressed(initData);
                      },
                    );
                  }).toList(),
                ),
              ),
            ))
        : Container();
  }
}
