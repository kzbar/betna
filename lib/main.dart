import 'package:betna/generated/l10n.dart';
import 'package:betna/providers/country_provider.dart';
import 'package:betna/setup/confing/web_mobile_calss.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/setup/router.dart';
import 'package:betna/style/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WM().configureApp();

  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) debugDefaultTargetPlatformOverride = TargetPlatform.android;
  //Provider.debugCheckInvalidValueType = null;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CountryProvider()..loadCountries()),
      ChangeNotifierProvider.value(value: MainProvider.init()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    String lang = View.of(context).platformDispatcher.locale.languageCode;
    return GetMaterialApp(
      localizationsDelegates: const [
        S.delegate,
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale(lang, ""),
      color: Colors.amber,
      initialRoute: '/',
      title: 'Betna real estate',
      theme: ThemeData(
        snackBarTheme: SnackBarThemeData(backgroundColor: Colors.white),
        textTheme: TextTheme(
            titleLarge: customStyle(
                lang, 24, Color(0xFF000000), FontWeight.bold, 1),
            titleMedium: customStyle(
                lang, 16, Color(0xFF000000), FontWeight.w700, 1),
            titleSmall: customStyle(
                lang, 12, Color(0xFF000000), FontWeight.w400, 1),
            headlineSmall:
                customStyle(lang, 14, Color(0xFF000000), FontWeight.w300, 1),
            bodyMedium:
                customStyle(lang, 14, Color(0xFF000000), FontWeight.w400, 1),
            bodySmall: customStyle(
                lang, 12, Color(0xFF000000), FontWeight.w300, 1)),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Style.primaryColors),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
      ),
      onGenerateRoute: (setting) {
        return generateRoute(setting, context);
      },
    );
  }

  TextStyle customStyle(String lang, double size, Color color,
      FontWeight weight, double height) {
    return lang == "ar"
        ? GoogleFonts.alexandria(
            height: height,

            fontSize: size,
            color: color,
            fontWeight: weight,
          )
        : GoogleFonts.roboto(
            height: height,

            fontSize: size,
            color: color,
            fontWeight: weight,
          );
  }
}
