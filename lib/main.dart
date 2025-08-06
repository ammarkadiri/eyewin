import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/Views/login/login_screen.dart';
import 'package:flutter_salesman_module/utils/provider/app_provider.dart';
import 'package:flutter_salesman_module/utils/route/app_router.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

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
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter().generateRoute,
      home: LoginScreen(),
    );
  }
}
