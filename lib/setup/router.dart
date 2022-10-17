import 'package:betna/home.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../page_404.dart';
import 'enumerators.dart';


Route<dynamic> generateRoute(RouteSettings settings, BuildContext context) {
  //AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
  if (kDebugMode) {
    print('generateRoute: ${settings.name}');
  }
  Uri uri = Uri.dataFromString(settings.name!);
  String path = uri.path.substring(1);
  if (kDebugMode) {
    print('path: ${path}');
  }
  String? param1 = uri.queryParameters['lang'];
  change(param1, context);
  PageRoute pageRoute =
      MaterialPageRoute(builder: (BuildContext context) => Page404());
  switch (path) {
    case '/':
      pageRoute = _buildRouteFade(settings, const Home());
      break;
  }
  return pageRoute;
}

PageRoute _buildRouteFade(
  RouteSettings settings,
  Widget builder,
) {
  return _FadedTransitionRoute(
    settings: settings,
    widget: builder,
  );
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget? widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({this.widget, required this.settings})
      : super(
            settings: RouteSettings(name: settings.name),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget!;
            },
            transitionDuration: const Duration(milliseconds: 100),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn,
                ),
                child: child,
              );
            });
}

Future change(param1, context) async {
  Future.delayed(const Duration(milliseconds: 300), () {
    //print(param1);
    if (param1 == 'ar') {
      Provider.of<MainProvider>(context, listen: false)
          .changeCurrentLang(Lang.AR);
    } else if (param1 == 'en') {
      Provider.of<MainProvider>(context, listen: false)
          .changeCurrentLang(Lang.EN);
    } else if (param1 == 'tr') {
      Provider.of<MainProvider>(context, listen: false)
          .changeCurrentLang(Lang.TR);
    }
  });
}
