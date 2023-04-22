import 'package:betna/rowsItems/row_item_empty.dart';
import 'package:betna/setup/general.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/responsive/device_screen_type.dart';
import 'package:betna/style/responsive/responsive_builder.dart';
import 'package:betna/style/style.dart';
import 'package:betna/style/widget/list_items_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

mixin ListViewMixin<T extends StatefulWidget> on State<T> {
  final ValueNotifier<int> isDisplayingDetail = ValueNotifier<int>(0);

  @override
  void dispose() {
    super.dispose();
  }

  int listCount = 0;

  String get title;

  LayoutBuilder get list;

  ListNotifier<dynamic> get notifier;

  List<dynamic> get listItem;

  List<Map<String,dynamic>> map = [];

  String? room = '*';

  String? inSide = '*';
  Query? query;


  bool get showFilterRom ;
  bool get showFilterInsideSite ;


  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    super.build(context);

    return ResponsiveBuilder(
      builder: (context, size) {
        double height = 0.0;
        double heightListBox = 0.0;
        double width = 0.0;
        double vertical = 0.0;
        switch (size.deviceScreenType) {
          case DeviceScreenType.Mobile:
            height = 360;
            width = MediaQuery.of(context).size.width * 0.95;
            vertical = 3;
            heightListBox = 270;

            break;
          case DeviceScreenType.Tablet:
            height = 450;
            heightListBox = 350;
            width = MediaQuery.of(context).size.width * 0.85;
            vertical = 12;
            break;
          case DeviceScreenType.Desktop:
            height = 450;
            heightListBox = 350;
            width = MediaQuery.of(context).size.width * 0.65;
            vertical = 12;

            break;
          default:
            height = 450;
            heightListBox = 350;
            width = MediaQuery.of(context).size.width * 0.65;
            vertical = 12;
            break;
        }
        var roomList = forSaleElements.singleWhere((element) => element['attribute'] == 'room');
        var inSideList = forSaleElements.singleWhere((element) => element['attribute'] == 'inside_site');
        Map<String, dynamic>? hint = roomList['hint'] as Map<String, dynamic>?;
        Map<String, dynamic>? hintinSide = inSideList['hint'] as Map<String, dynamic>?;
        List _roomList = roomList['list'] as List<dynamic>? ?? [];
        List _inSideList = inSideList['list'] as List<dynamic>? ?? [];
        String lang = Provider.of<MainProvider>(context, listen: false).kLang;

        return Container(
          margin: EdgeInsets.symmetric(vertical: vertical),
          padding: EdgeInsets.only(top: 6, right: vertical, left: vertical),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              color: Colors.white70),
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: title,
                    size: 24,
                    weight: FontWeight.bold,
                    color: Style.lavenderBlack,
                  ),
                  const Spacer(),
                  if(showFilterRom)
                  SizedBox(
                    width: 60,
                    child: FormBuilderDropdown(
                      iconSize: 30,
                      onChanged: (val) {
                        setState(() {
                          room = val.toString();
                          query = Query(room: room, insideSite: inSide);

                        });
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: hint![lang],
                          labelStyle: const TextStyle(
                              fontSize: 10,
                              fontFamily: 'LBC',
                              color: Colors.blue,

                              fontWeight: FontWeight.bold)),
                      initialValue: "*",
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      name: roomList['attribute'] as String,
                      items: _roomList.map((e) {
                        return DropdownMenuItem(
                          alignment: Alignment.center,
                          value: e,
                          child: CustomText(
                            text: e,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  if(showFilterInsideSite)
                  SizedBox(
                    width: 70,
                    child: FormBuilderDropdown(
                      iconSize: 30,
                      onChanged: (val) {
                        setState(() {
                          inSide = val.toString();
                          query = Query(room: room, insideSite: inSide);
                        });
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: hintinSide![lang],
                          labelStyle: const TextStyle(
                              fontSize: 10,
                              color: Colors.blue,
                              fontFamily: 'LBC',
                              fontWeight: FontWeight.bold)),
                      initialValue: "*",
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      name: inSideList['attribute'] as String,
                      items: _inSideList.map((e) {
                        String text = e;
                        switch(lang){
                          case 'ar':
                            if(e == 'no'){
                              text = 'لا';
                            }else if(e=='yes'){
                              text = 'نعم';
                            }else{
                              text = '*';
                            }
                            break;
                          case 'tr':
                            if(e == 'no'){
                              text = 'Hayır';
                            }else if(e == 'yes'){
                              text = 'Evet';
                            }else{
                              text = '*';
                            }
                            break;

                        }

                        return DropdownMenuItem(
                          alignment: Alignment.center,
                          value: e,
                          child: CustomText(
                            text: text,
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 6.0,
              ),
              SizedBox(
                height: heightListBox,
                child: FutureBuilder(
                  future: notifier.fetchDataState,
                  builder: (BuildContext context,AsyncSnapshot<FetchDataState> snapshot) {
                    switch (snapshot.data) {
                      case FetchDataState.done:
                        return notifier.list!.isNotEmpty
                            ? list
                            : ListItemsEmpty();
                      case FetchDataState.wait:
                        return Scrollbar(
                            child: ListView.builder(
                                itemCount: 5,
                                primary: true,
                                shrinkWrap: true,
                                //just set this property
                                padding: const EdgeInsets.only(
                                    bottom: 24, top: 0, right: 12, left: 12),
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
                                padding: const EdgeInsets.only(
                                    bottom: 24, top: 0, right: 12, left: 12),
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
                                  padding: const EdgeInsets.only(
                                      bottom: 24, top: 0, right: 12, left: 12),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, itemCount) {
                                    return const EmptyRowItem();
                                  }));
                        }
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
class Query {
  final String? room;
  final String? insideSite;
  Query({required this.room, required this.insideSite});
}

