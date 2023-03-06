import 'package:betna/bar.dart';
import 'package:betna/style/main_app_scaffold.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MainAppScaffold(
        child: Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        children: [CustomBar()],
      ),
    ));
  }
}
