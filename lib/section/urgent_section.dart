import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:betna/generated/l10n.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/style/widget/list_items_empty.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/sale_ad_model.dart';
import '../rowsitems/urgent_row_item.dart';
import '../setup/tools.dart';
import '../style/custom_text.dart';
import '../style/popover/context_menu_overlay.dart';
import '../style/style.dart';
import '../style/widget/skeleton.dart';

enum FilterList { seeAll, affordableHomes, luxuryHomes }

class UrgentSection extends StatefulWidget {
  const UrgentSection({super.key});

  @override
  State<StatefulWidget> createState() => _UrgentSection();
}

class _UrgentSection extends State<UrgentSection> {
  @override
  Widget build(BuildContext context) {
    ListNotifier<SaleAdModel> notifier =
        Provider.of<MainProvider>(context, listen: true).saleList;
    List<SaleAdModel> listResult =
        notifier.list!.where((element) => element.urgent == 'yes').toList();
    listResult.sort(
        (a, b) => b.available.toString().compareTo(a.available.toString()));
    double h1 = 200;

    return FutureBuilder(
      future: notifier.fetchDataState,
      builder: (BuildContext context, AsyncSnapshot<FetchDataState> snapshot) {
        if(snapshot.hasData){

          if(snapshot.data! == FetchDataState.wait){
            return AnimatedContainer(
              height: h1,
              duration: const Duration(milliseconds: 2000),
              child:  AnimatedContainer(
                height: h1,
                width: MediaQuery.of(context).size.width,
                duration: Duration(milliseconds: 2000),
                child: Scrollbar(
                    child: ListView.builder(
                        itemCount: 5,
                        primary: true,
                        shrinkWrap: true,
                        //just set this property
                        padding: const EdgeInsets.only(
                            bottom: 0, top: 12, right: 12, left: 12),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, itemCount) {
                          return const EmptyRowItem();
                        })),
              ),
            );
          }else if(snapshot.data! == FetchDataState.done){
            double h1 = 0;

            double h = listResult.isEmpty ? 0 : 220;
            return AnimatedContainer(
              height: h,
              padding: const EdgeInsets.only(left: 48, right: 48, bottom: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  color: Style.primaryColors.withOpacity(0.075)),
              duration: Duration(milliseconds: 500),
              child: ListView(
                children: [
                  Container(
                    padding:
                    const EdgeInsets.only(left: 12, right: 12, top: 6),
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
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: ListView.builder(
                        itemCount: listResult.length,
                        primary: true,
                        shrinkWrap: true,
                        //just set this property
                        padding: const EdgeInsets.only(
                            bottom: 10, top: 0, right: 0, left: 0),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, itemCount) {
                          SaleAdModel _model = listResult[itemCount];
                          return UrgentRowItem(
                            model: _model,
                            tag: '_urgent',
                          );
                        }),
                  ),
                ],
              ),
            );
          }
        }
        return Container();
      },
    );
  }
}

class EmptyRowItem extends StatelessWidget {
  const EmptyRowItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ContextMenuRegion(
        contextMenu: TextButton(
          onPressed: () {},
          child: const Text('Share'),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: Corners.lgBorder,
              boxShadow: Shadows.small),
          width: 130,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: Corners.lgBorderTop,
                    child: Skeleton(
                      cornerRadius: 0.0,
                      height: 90,
                      width: 130,
                      showCircular: false,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 6,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        InfoTextWidget(
                          text1: 'Loading',
                          text2: '',
                        ),
                        InfoTextWidget(
                          text1: 'Loading',
                          text2: '',
                        ),
                      ],
                    ),
                  ),
                  CustomText(
                    text: Constants.convertPrice(context, "1000000"),
                    size: 15,
                    color: Style.lavenderBlack,
                    weight: FontWeight.bold,
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  margin: const EdgeInsets.only(),
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: Corners.medBorder,
                      color: Style.primaryColors),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomText(
                        text: 'New'.toUpperCase(),
                        size: 10,
                        color: Colors.white,
                      ),
                      CustomText(
                        text: ' - ',
                        size: 10,
                        color: Colors.white,
                      ),
                      CustomText(
                        text: Constants.timeAgoSinceDate(
                                DateTime.fromMillisecondsSinceEpoch(
                                        DateTime.now().millisecondsSinceEpoch)
                                    .toIso8601String(),
                                context: context)
                            .toUpperCase(),
                        size: 10,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoTextWidget extends StatelessWidget {
  final String? text1;
  final String? text2;

  const InfoTextWidget({Key? key, this.text1, this.text2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        children: [
          CustomText(
            text: text1,
            color: Colors.black45,
            size: 6,
          ),
          const SizedBox(
            width: 1,
          ),
          CustomText(
            text: text2,
            color: Colors.black,
            weight: FontWeight.bold,
            size: 6,
          ),
        ],
      ),
    );
  }
}
