import 'package:betna/style/responsive/sizing_information.dart';
import 'package:betna/style/responsive/ui_utils.dart';
import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget? Function(
    BuildContext context,
    SizingInformation sizingInformation,
  )?
  builder;
  const ResponsiveBuilder({super.key, this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxConstraints) {
        var mediaQuery = MediaQuery.of(context);
        var sizingInformation = SizingInformation(
          deviceScreenType: getDeviceType(mediaQuery),
          screenSize: mediaQuery.size,
          localWidgetSize: Size(
            boxConstraints.maxWidth,
            boxConstraints.maxHeight,
          ),
        );
        return builder!(context, sizingInformation)!;
      },
    );
  }
}
