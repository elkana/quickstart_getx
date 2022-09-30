import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'configs/locales.dart';
import 'controllers/auth_controller.dart';
import 'controllers/pref_controller.dart';
import 'home/home_view.dart';
import 'login/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
          initialRoute: '/login',
          initialBinding: BindingsBuilder(() {
            Get.put(AuthController());
          }),
          onInit: () async {
            await Get.put(PrefController()).initStorage();
          },
          themeMode: ThemeMode.dark,
          locale: const Locale('en', 'US'),
          translationsKeys: AppTranslation.translations,
          getPages: [
            GetPage(name: '/login', page: () => const LoginView(), binding: LoginBinding()),
            GetPage(name: '/home', page: () => const HomeView(), binding: HomeBinding()),
          ]);
}
