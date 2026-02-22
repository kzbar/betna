import 'package:betna/pages/betna_home_page.dart';
import 'package:betna/pages/sale_request_page.dart';
import 'package:betna/pages/page_404.dart';
import 'package:betna/pages/about_page.dart';
import 'package:betna/pages/projects_page.dart';
import 'package:betna/pages/resale_page.dart';
import 'package:betna/pages/eids_authorization_page.dart';
import 'package:betna/pages/property_admin_page.dart';
import 'package:betna/pages/property_detail_page.dart';
import 'package:betna/models/property_model.dart';
import 'package:betna/providers/main_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'enumerators.dart';

Route<dynamic> generateRoute(RouteSettings settings, BuildContext context) {
  if (kDebugMode) {
    print('generateRoute: ${settings.name}');
  }
  final uri = Uri.parse(settings.name ?? '/');
  final path = uri.path;
  if (kDebugMode) {
    print('path: $path');
  }
  PageRoute pageRoute = MaterialPageRoute(
    builder: (BuildContext context) => Page404(),
  );

  // Only apply device locale on first load (when no language chosen yet)
  final mainProvider = Provider.of<MainProvider>(context, listen: false);
  if (mainProvider.currentLang == null) {
    String lang = View.of(context).platformDispatcher.locale.languageCode;
    if (kDebugMode) {
      print("device lang $lang");
    }
    if (lang.contains('ar')) {
      change('ar', context);
    } else if (lang.contains('tr')) {
      change('tr', context);
    } else {
      change('en', context);
    }
  }

  switch (path) {
    case '/':
      pageRoute = _buildRouteFade(settings, const BetnaHomePage());
      break;
    case '/about':
      pageRoute = _buildRouteFade(settings, const AboutUsPage());
      break;
    case '/projects':
      pageRoute = _buildRouteFade(settings, const ProjectsPage());
      break;
    case '/resale':
      pageRoute = _buildRouteFade(settings, const ResalePage());
      break;
    case '/sale-request':
      pageRoute = _buildRouteFade(settings, const SaleRequestPage());
      break;
    case '/eids':
      pageRoute = _buildRouteFade(settings, const EidsAuthorizationPage());
      break;
    case '/admin':
      pageRoute = _buildRouteFade(settings, const PropertyAdminPage());
      break;
    case '/property-detail':
      final property = settings.arguments as PropertyModel?;
      if (property != null) {
        pageRoute = _buildRouteFade(
          settings,
          PropertyDetailPage(property: property),
        );
      } else {
        pageRoute = _buildRouteFade(settings, const BetnaHomePage());
      }
      break;
  }
  return pageRoute;
}

PageRoute _buildRouteFade(RouteSettings settings, Widget builder) {
  return _FadedTransitionRoute(settings: settings, widget: builder);
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget? widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({this.widget, required this.settings})
    : super(
        settings: RouteSettings(name: settings.name),
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return widget!;
            },
        transitionDuration: const Duration(milliseconds: 100),
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn,
                ),
                child: child,
              );
            },
      );
}

Future<void> change(String param1, BuildContext context) async {
  Future.delayed(const Duration(milliseconds: 100), () {
    if (param1 == 'ar') {
      Provider.of<MainProvider>(
        context,
        listen: false,
      ).changeCurrentLang(Lang.AR);
    } else if (param1 == 'en') {
      Provider.of<MainProvider>(
        context,
        listen: false,
      ).changeCurrentLang(Lang.EN);
    } else if (param1 == 'tr') {
      Provider.of<MainProvider>(
        context,
        listen: false,
      ).changeCurrentLang(Lang.TR);
    }
  });
}
