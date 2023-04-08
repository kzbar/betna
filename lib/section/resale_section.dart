import 'package:betna/rowsItems/sale_row_item.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/style/widget/list_items_empty.dart';
import 'package:betna/rowsItems/row_item_empty.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/sale_ad_model.dart';

enum FilterList { seeAll, affordableHomes, luxuryHomes }

class SaleListWidget extends StatelessWidget {
  final FilterList filterList;

  const SaleListWidget({
    Key? key,
    this.filterList = FilterList.seeAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListNotifier<SaleAdModel> notifier =
        Provider.of<MainProvider>(context, listen: true).saleList;
    List<SaleAdModel> listResult = notifier.list!;
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
                        bottom: 0, top: 12, right: 6, left: 6),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, itemCount) {
                      SaleAdModel _model = listResult[itemCount];
                      return SaleRowItem(
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
