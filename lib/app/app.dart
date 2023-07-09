import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/routes/navigation_manager.dart';
import 'package:flutter_application_1/app/routes/route_constants.dart';
import 'package:flutter_application_1/app/routes/routes_generator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data/network/local/local_network.dart';
import '../presentation/resources/theme_manager.dart';
import 'locator.dart';

class MyApp extends StatelessWidget {
  const MyApp._internal();

  static const _instance = MyApp._internal();

  factory MyApp() => _instance;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => SafeArea(
        child: MaterialApp(
          theme: getApplicationTheme(),
          debugShowCheckedModeBanner: false,
          // initialRoute: RouteConstants.loginRoute,
          initialRoute: getIt<SharedPrefController>().getLoggedIn()
              ? RouteConstants.homeRoute
              : RouteConstants.loginRoute,
          onGenerateRoute: RouteGenerator.generateRoutes,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          navigatorKey: NavigationManager.navigatorKey,
        ),
      ),
    );
  }
}
