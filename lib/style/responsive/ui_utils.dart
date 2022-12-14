import 'package:flutter/widgets.dart';

import 'device_screen_type.dart';

DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
  double deviceWidth = mediaQuery.size.width;

  if (deviceWidth > 1280) {
    return DeviceScreenType.Desktop;
  }

  if (deviceWidth > 800) {
    return DeviceScreenType.Tablet;
  }

  return DeviceScreenType.Mobile;
}
