import 'package:betna/generated/l10n.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/setup/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';
import 'package:maker/models/contract_object.dart';
import 'package:maker/web_control_panal/provider/app_provider.dart';
import 'package:maker/web_control_panal/provider/auth.dart';
import 'services/firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:maker/generated/l10n.dart' as makr;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugDefaultTargetPlatformOverride = TargetPlatform.android;
  //Provider.debugCheckInvalidValueType = null;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: MainProvider.init()),
      ChangeNotifierProvider.value(value: AppProvider.init()),
      ChangeNotifierProvider.value(value: AuthProvider.initialize()),
      ChangeNotifierProvider.value(value: ModelContract()),
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
    return GetMaterialApp(
      localizationsDelegates: const [
        makr.S.delegate,
        S.delegate,
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('tr', ''),
        Locale('ar', ''),
      ],
      locale: Locale(Provider.of<MainProvider>(context).kLang, ""),
      color: Colors.amber,
      initialRoute: '/',
      title: 'Betna real estate',
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
