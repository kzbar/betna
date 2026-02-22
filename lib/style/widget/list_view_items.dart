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
  final List? listItems;

  const ListViewItems({
    super.key,
    this.title = '',
    this.titleAction = '',
    this.list,
    this.function,
    this.listItems,
  });

  @override
  Widget build(BuildContext context) {
    return ContextMenuRegion(
      contextMenu: Container(),
      child: ResponsiveBuilder(
        builder: (context, size) {
          double height = 0.0;
          double heightListBox = 0.0;
          double width = 0.0;
          double vertical = 0.0;
          switch (size.deviceScreenType) {
            case DeviceScreenType.Mobile:
              height = 325;
              width = MediaQuery.of(context).size.width * 0.90;
              vertical = 3;
              heightListBox = 250;

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
          return Container(
            margin: EdgeInsets.symmetric(vertical: vertical),
            padding: EdgeInsets.only(top: 24, right: vertical, left: vertical),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: Colors.white70,
            ),
            width: width,
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(text: title, size: 12, color: Style.lavenderBlack),
                const SizedBox(height: 12.0),
                // InkWell(
                //   onTap: function as void Function()?,
                //   child: CustomText(
                //     text: titleAction,
                //     size: 14,
                //     color: Colors.blue,
                //     color: Colors.blue,
                //   ),
                // ),
                SizedBox(
                  width: double.infinity,
                  height: heightListBox,
                  child: list,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
