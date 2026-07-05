import 'package:flutter/material.dart';
import 'package:my_doctor/features/auth/presentation/screens/login/login_screen.dart';
import 'package:my_doctor/features/auth/presentation/screens/signup/signup_screen.dart';
import 'package:my_doctor/features/details/data/details_data.dart';
import 'package:my_doctor/features/details/presentation/screens/details_screen.dart';
import 'package:my_doctor/features/details/presentation/screens/wireframe/details_wireframe.dart';
import 'package:my_doctor/features/home/presentation/screens/home_screen.dart';
import 'package:my_doctor/features/home/presentation/screens/wireframe/home_wireframe.dart';
import 'package:my_doctor/features/splash/presentation/screens/splashscreen.dart';
import 'package:my_doctor/features/splash/presentation/screens/wireframe/splash_wireframe.dart';

class AppRoutes {
  static const String splash = '/';
  static const String splashwireframe = '/splashwireframe';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String homewireframe = '/homewireframe';
  static const String details = '/details';
  static const String detailswireframe = '/detailswireframe';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.splashwireframe:
        return MaterialPageRoute(builder: (_) => const SplashWireframe());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.homewireframe:
        return MaterialPageRoute(builder: (_) => const HomeWireframe());

      case AppRoutes.details:
        final args = settings.arguments;
        if (args is! DetailsData) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('لم يتم تمرير بيانات الطبيب')),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => DetailsScreen(doctor: args),
        );
      case AppRoutes.detailswireframe:
        final args = settings.arguments;
        if (args is! DetailsData) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('لم يتم تمرير بيانات الطبيب')),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => DetailsWireframe(doctor: args),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page Not Found'),
            ),
          ),
        );
    }
  }
}
