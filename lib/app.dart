import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_doctor/core/routing/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(365, 832),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(fontFamily: 'FinlandicaHeadline'),
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splashwireframe,
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
