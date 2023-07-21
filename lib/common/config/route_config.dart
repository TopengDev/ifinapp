import 'package:ifinapp/common/common.dart';
import 'package:ifinapp/ui/ui.dart';
import 'package:flutter/material.dart';

class RouteConfig {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    final dynamic args = routeSettings.arguments;
    switch (routeSettings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(
          settings: RouteSettings(
            arguments: args,
          ),
          builder: (_) => const SplashScreen(),
        );
      case RouteName.loginScreen:
        return MaterialPageRoute(
          settings: RouteSettings(
            arguments: args,
          ),
          builder: (_) => const LoginScreen(),
        );
      case RouteName.registerScreen:
        return MaterialPageRoute(
          settings: RouteSettings(
            arguments: args,
          ),
          builder: (_) => const RegisterScreen(),
        );
      case RouteName.landingScreen:
        return MaterialPageRoute(
          settings: RouteSettings(
            arguments: args,
          ),
          builder: (_) => const LandingScreen(),
        );
      case RouteName.learningScreen:
        return MaterialPageRoute(
          settings: RouteSettings(
            arguments: args,
          ),
          builder: (_) => const LearningScreen(),
        );
      case RouteName.qnaScreen:
        return MaterialPageRoute(
          settings: RouteSettings(
            arguments: args,
          ),
          builder: (_) {
            LearningModel learning = args as LearningModel;
            return QnaScreen(learning: learning);
          },
        );
      case RouteName.learningProgressScreen:
        return MaterialPageRoute(
          settings: RouteSettings(
            arguments: args,
          ),
          builder: (_) => const LearningProgressScreen(),
        );
      case RouteName.successScreen:
        return MaterialPageRoute(
          settings: RouteSettings(
            arguments: args,
          ),
          builder: (_) => const SuccessScreen(),
        );
      case RouteName.failScreen:
        return MaterialPageRoute(
          settings: RouteSettings(
            arguments: args,
          ),
          builder: (_) => const FailScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Halaman Tidak Ditemukan'),
            ),
          ),
        );
    }
  }
}
