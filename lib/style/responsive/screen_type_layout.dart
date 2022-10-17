import 'package:betna/style/responsive/responsive_builder.dart';
import 'package:flutter/material.dart';

import 'device_screen_type.dart';

class ScreenTypeLayout extends StatelessWidget {
  final Widget? mobile ;
  final Widget? tablet;
  final Widget? desktop;
  const ScreenTypeLayout({
    Key? key,
    this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        switch(sizingInformation.deviceScreenType){
          case DeviceScreenType.Mobile:
            return mobile ?? const Center(child: Text('mobile'),);
          case DeviceScreenType.Tablet:
            return tablet ?? desktop;
          case DeviceScreenType.Desktop:
            return desktop;
          default :{
            return mobile ?? const Center(child: Text('mobile'),);
          }
        }
        },
    );
  }
}
