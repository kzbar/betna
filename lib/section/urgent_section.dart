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

class UrgentListWidget extends StatelessWidget {
  final FilterList filterList;

  const UrgentListWidget({
    Key? key,
    this.filterList = FilterList.seeAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListNotifier<SaleAdModel> notifier =
        Provider.of<MainProvider>(context, listen: true).saleList;
    List<SaleAdModel> listResult = notifier.list!.where((element) => element.urgent == true).toList();
    switch (notifier.fetchDataState) {
      case FetchDataState.done:
        return listResult.isNotEmpty
            ? Scrollbar(
                child: ListView.builder(
                    itemCount: listResult.length,
                    primary: true,
                    shrinkWrap: true,
                    //just set this property
                    padding: const EdgeInsets.only(
                        bottom: 0, top: 0, right: 0, left: 0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, itemCount) {
                      SaleAdModel _model = listResult[itemCount];
                      return UrgentRowItem(
                        model: _model,
                        tag: '${filterList.index}',
                      );
                    }))
            : ListItemsEmpty();
      case FetchDataState.wait:
        return Scrollbar(
            child: ListView.builder(
                itemCount: 1,
                primary: true,
                shrinkWrap: true,
                //just set this property
                padding:
                    const EdgeInsets.only(bottom: 0, top: 12, right: 12, left: 12),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, itemCount) {
                  return const EmptyRowItem();
                }));
      case FetchDataState.error:
        return Container();
      case FetchDataState.none:
        return Scrollbar(
            child: ListView.builder(
                itemCount: 1,
                primary: true,
                shrinkWrap: true,
                //just set this property
                padding:
                    const EdgeInsets.only(bottom: 0, top: 12, right: 12, left: 12),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, itemCount) {
                  return const EmptyRowItem();
                }));
      default:
        {
          return Scrollbar(
              child: ListView.builder(
                  itemCount: 1,
                  primary: true,
                  shrinkWrap: true,
                  //just set this property
                  padding:
                      const EdgeInsets.only(bottom: 0, top: 12, right: 12, left: 12),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, itemCount) {
                    return const EmptyRowItem();
                  }));
        }
    }
  }
}
class EmptyRowItem extends StatelessWidget {

  const EmptyRowItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
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
          width: 150,
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
                      height: 150,
                      width: 150,
                      showCircular: false,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 0,
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
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        InfoTextWidget(
                          text1: 'Loading',
                          text2:
                          '',
                        ),
                        InfoTextWidget(
                          text1: 'Loading',
                          text2:
                          '',
                        ),
                      ],
                    ),
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
                      borderRadius: Corners.medBorder, color: Style.primaryColors),
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
                                .toIso8601String(),context: context)
                            .toUpperCase(),

                        size: 10,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 90,
                left: 12,
                child: Column(
                  textDirection: TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Home',
                      size: 12,
                      color: Colors.white,
                    ),
                    CustomText(
                      text: Constants.convertPrice(context, "1000000"),
                      size: 20,
                      color: Colors.white,
                      weight: FontWeight.bold,
                      textDirection: TextDirection.ltr,
                    ),
                  ],
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
