import 'package:betna/generated/l10n.dart';
import 'package:betna/providers/country_provider.dart';
import 'package:betna/setup/confing/web_mobile_calss.dart';
import 'package:betna/providers/main_provider.dart';
import 'package:betna/setup/router.dart';
import 'package:betna/style/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';
import 'services/firebase_options.dart';
import 'package:betna/providers/sale_request_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:betna/providers/property_provider.dart';

Future<void> main() async {
  WM().configureApp();

  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) debugDefaultTargetPlatformOverride = TargetPlatform.android;
  //Provider.debugCheckInvalidValueType = null;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CountryProvider()..loadCountries(),
        ),
        ChangeNotifierProvider.value(value: MainProvider.init()),
        ChangeNotifierProvider(create: (_) => SaleRequestProvider()),
        ChangeNotifierProvider(create: (_) => PropertyProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Consumer<MainProvider>(
      builder: (context, mainProvider, _) {
        final lang = mainProvider.kLang;
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
          title: 'Betna Real Estate',
          theme: ThemeData(
            fontFamily: lang == "ar" ? 'LBC' : 'AEOB',
            scaffoldBackgroundColor: Style.luxuryCharcoal,
            snackBarTheme: SnackBarThemeData(
              backgroundColor: Style.luxurySurface,
              contentTextStyle: const TextStyle(color: Colors.white),
            ),
            textTheme: TextTheme(
              labelSmall: _customStyle(
                lang,
                12,
                Colors.white,
                FontWeight.w100,
                1,
                lang == "ar" ? 'LBC' : 'AEOB',
              ),
              labelMedium: _customStyle(
                lang,
                24,
                Colors.white,
                FontWeight.w500,
                1.1,
                lang == "ar" ? 'LBC' : 'AEOB',
              ),
              bodyLarge: _customStyle(
                lang,
                32,
                Colors.white,
                FontWeight.w700,
                1.1,
                lang == "ar" ? 'LBC' : 'AEOB',
              ),
              headlineLarge:_customStyle(
                lang,
                32,
                Colors.white,
                FontWeight.w700,
                1.1,
                lang == "ar" ? 'LBC' : 'AEOB',
              ),
              headlineMedium: _customStyle(
                lang,
                24,
                Colors.white,
                FontWeight.w600,
                1.1,
                lang == "ar" ? 'LBC' : 'AEOB',
              ),
              displaySmall: _customStyle(
                lang,
                12,
                Colors.white,
                FontWeight.w200,
                1.1,
                lang == "ar" ? 'LBC' : 'AEOB',
              ),
              displayMedium: _customStyle(
                lang,
                24,
                Colors.white,
                FontWeight.w500,
                1.1,
                lang == "ar" ? 'LBC' : 'AEOB',
              ),
              displayLarge: _customStyle(
                lang,
                32,
                Colors.white,
                FontWeight.w700,
                1.1,
                lang == "ar" ? 'LBC' : 'AEOB',
              ),
              titleLarge: _customStyle(
                lang,
                32,
                Colors.white,
                FontWeight.w700,
                1.1,
                lang == "ar" ? 'LBC' : 'AEOB',
              ),
              titleMedium: _customStyle(
                lang,
                24,
                Colors.white,
                FontWeight.w600,
                1.2,
                lang == "ar" ? 'LBC' : 'AEOB',
              ),
              titleSmall: _customStyle(
                lang,
                18,
                Style.luxuryGold,
                FontWeight.w500,
                1.2,
                lang == "ar" ? 'LBC' : 'AEOB',
              ),
              headlineSmall: _customStyle(
                lang,
                16,
                Colors.white.withValues(alpha: 0.9),
                FontWeight.w600,
                1.3,
                lang == "ar" ? 'LBC' : 'AEOB',
              ),
              bodyMedium: _customStyle(
                lang,
                15,
                Colors.white.withValues(alpha: 0.7),
                FontWeight.w400,
                1.6,
                lang == "ar" ? 'LBC' : 'AEOB',
              ),
              bodySmall: _customStyle(
                lang,
                13,
                Colors.white.withValues(alpha: 0.5),
                FontWeight.w300,
                1.6,
                lang == "ar" ? 'LBC' : 'AEO',
              ),

            ),
            useMaterial3: true,
            primaryColor: Style.primaryMaroon,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Style.primaryMaroon,
              primary: Style.primaryMaroon,
              secondary: Style.luxuryGold,
              onSecondary: Colors.white,
              surface: Style.luxurySurface,
              onSurface: Colors.white,
              brightness: Brightness.dark,
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.03),
              border: OutlineInputBorder(
                borderRadius: Corners.medBorder,
                borderSide: BorderSide(color: Style.border, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: Corners.medBorder,
                borderSide: BorderSide(color: Style.border, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: Corners.medBorder,
                borderSide: BorderSide(color: Style.luxuryGold, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Style.primaryMaroon,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: Corners.medBorder),
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
              ),
            ),
          ),
          onGenerateRoute: (setting) {
            return generateRoute(setting, context);
          },
        );
      },
    );
  }

  static TextStyle _customStyle(
    String lang,
    double size,
    Color color,
    FontWeight weight,
    double height,
    String fontFamily,
  ) {
    return TextStyle(
      fontFamily: fontFamily,
      height: height,
      fontSize: size,
      color: color,
      fontWeight: weight,
    );
  }
}
