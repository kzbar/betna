import 'package:betna/desktop.dart';
import 'package:betna/style/main_app_scaffold.dart';
import 'package:betna/style/responsive/screen_type_layout.dart';
import 'package:betna/tablet.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'mobile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: MainAppScaffold(
            child: ScreenTypeLayout(
              mobile: MobilePage(),
              desktop: Desktop(),
              tablet: Tablet(),
            )));
  }
}
