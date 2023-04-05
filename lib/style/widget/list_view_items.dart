import 'package:betna/style/popover/context_menu_overlay.dart';
import 'package:betna/style/responsive/device_screen_type.dart';
import 'package:betna/style/responsive/responsive_builder.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';

import '../custom_text.dart';

class ListViewItems extends StatelessWidget {
  final String title;
  final String titleAction;
  final Widget? list;
  final Function? function;

  const ListViewItems(
      {Key? key,
      this.title = '',
      this.titleAction = '',
      this.list,
      this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContextMenuRegion(
      contextMenu: Container(),
      child: ResponsiveBuilder(
        builder: (context, size) {
          double _w = MediaQuery.of(context).size.width * 0.65;
          double m = MediaQuery.of(context).size.width * 0.15;
          return Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              padding: const EdgeInsets.only(top: 24,right: 12,left: 12),
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  color: Colors.white70),
              width: _w,
              height: 450,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: title,
                    size: 20,
                    color: Style.lavenderBlack,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  // InkWell(
                  //   onTap: function as void Function()?,
                  //   child: CustomText(
                  //     text: titleAction,
                  //     size: 14,
                  //     color: Colors.blue,
                  //   ),
                  // ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 350,
                    child: list,
                  ),
                ],
              ),);
        },
      ),
    );
  }
}
