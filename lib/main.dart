import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_salesman_module/Views/login/login_screen.dart'; 
import 'package:flutter_salesman_module/utils/provider/app_provider.dart';
import 'package:flutter_salesman_module/utils/route/app_router.dart';
import 'package:flutter_salesman_module/utils/services/global_methods.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MultiProvider(providers: appProviders, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale(GlobalMethods.getLocale()),
      //locale: const Locale("ar"),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter().generateRoute,
      home: LoginScreen(),
    );
  }
}
