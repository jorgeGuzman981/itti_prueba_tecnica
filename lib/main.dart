import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prueba_tecnica_itti/pages/home_page.dart';
import 'package:prueba_tecnica_itti/pages/login_page.dart';
import 'package:prueba_tecnica_itti/utils/app_colors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        var themeData = ThemeData(
          primaryColor: AppColors.primaryColor,
          inputDecorationTheme:const InputDecorationTheme(
            labelStyle: TextStyle(color: AppColors.textColor1),
            suffixIconColor: AppColors.primaryColor,
          )
        );
        return MaterialApp(
        theme: themeData,
        debugShowCheckedModeBanner: false,
        title: 'Prueba Técnica',
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LogInPage(),
          '/home': (context) => const HomePage()
        },
      );
      },
    );
  }
}
