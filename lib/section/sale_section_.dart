import 'package:betna/generated/l10n.dart';
import 'package:betna/listView_mixin.dart';
import 'package:betna/rowsItems/sale_row_item.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/sale_ad_model.dart';

class NewSaleSection extends StatefulWidget {
  const NewSaleSection({super.key});

  @override
  State<StatefulWidget> createState() => _NewSaleSection();
}

@mustCallSuper
class _NewSaleSection extends State<NewSaleSection>
    with
        AutomaticKeepAliveClientMixin,
        ListViewMixin,
        TickerProviderStateMixin
        {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  AnimationController? _controller ;
  Animation<Offset>? _offsetAnimation ;

  List<dynamic> listToShow = [];
  List<dynamic> listBase = [];


  @override
  ListNotifier get notifier {
    listBase = Provider.of<MainProvider>(context, listen: true).saleList.list!;
    String lang = Provider.of<MainProvider>(context, listen: true).kLang;
    listToShow = listBase;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
    begin: Offset( lang == 'ar' ?-1 :1, 0.0),
    end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
    parent: _controller!,
    curve: Curves.linear,
    ));
    _controller!.forward();
    return Provider.of<MainProvider>(context, listen: true).saleList;
  }

  @override
  String get title => S.of(context).kSale;

  @override
  bool get wantKeepAlive => true;

  @override
  // TODO: implement list
  LayoutBuilder get list {
    List<dynamic> listS = [];

    /// sort available to unavailable
    if (query != null) {
      listS = listToShow
          .where((element) =>
              query!.room == null ||
              query!.room == '*' ||
              query!.room! == element.room)
          .toList();
      listS = listS
          .where((element) =>
              query!.insideSite == null ||
              query!.insideSite == '*' ||
              query!.insideSite! == element.insideSite)
          .toList();
      listToShow = [...listS];
      _controller!.forward(from: 0.6);
    }
    listToShow.sort(
        (a, b) => b.available.toString().compareTo(a.available.toString()));
    listCount = listToShow.length;

    return LayoutBuilder(
      builder: (context, box) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: listToShow.isNotEmpty
                  ? ListView.builder(
                      itemCount: listToShow.length,
                      shrinkWrap: false,
                      //just set this property
                      padding: const EdgeInsets.only(
                          bottom: 6, top: 6, right: 6, left: 6),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, itemCount) {
                        SaleAdModel model = listToShow[itemCount];
                        return SlideTransition(
                          position: _offsetAnimation!,
                          child: SaleRowItem(
                            model: model,
                            tag: '${''}_sale',
                          ),
                        );
                      })
                  : Center(
                      child: CustomText(
                        text: S.of(context).kNoOffer,
                      ),
                    ),
            ),
            const SizedBox(
              height: 12,
            ),
            CustomText(
              text: S.of(context).kOfferLength('${listToShow.length}'),
              size: 12,
              color: Style.lavenderBlack,
            ),
          ],
        );
      },
    );
  }

  @override
  List get listItem => listToShow;

  @override
  // TODO: implement showFilterInsideSite
  bool get showFilterInsideSite => true;

  @override
  // TODO: implement showFilterRom
  bool get showFilterRom => true;

}
