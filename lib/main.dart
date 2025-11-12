import 'package:betna/generated/l10n.dart';
import 'package:betna/setup/confing/web_mobile_calss.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/setup/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';
import 'services/firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:ui' as ui;

Future<void> main() async {
  WM().configureApp();

  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) debugDefaultTargetPlatformOverride = TargetPlatform.android;
  //Provider.debugCheckInvalidValueType = null;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
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
    String lang =  View.of(context).platformDispatcher.locale.languageCode;
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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0E7490)),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: Provider.of<MainProvider>(context).textDecoration,
          child: child!,
        );
      },
      onGenerateRoute: (setting) {
        return generateRoute(setting, context);
      },
    );
  }
}
