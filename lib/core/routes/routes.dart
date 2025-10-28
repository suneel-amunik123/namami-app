import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:namami/core/routes/enum.dart';
export 'package:namami/core/routes/enum.dart';
import 'package:namami/core/widgets/splash_screen.dart';
import 'package:namami/features/auth/view/login_view.dart';
import 'package:namami/features/auth/view/otp_view.dart';
import 'package:namami/features/auth/view/register_view.dart';
import 'package:namami/features/home/home_view.dart';

class RouteManager {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings? settings) {
    try {
      // Handle root route
      if (settings?.name == '/') {
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      }
      
      final route = Routes.values.firstWhere((r) => r.path == settings?.name);
      return MaterialPageRoute(
        builder: (_) => getPage(route, arguments: settings?.arguments),
        settings: settings,
      );
    } catch (error) {
      log('Route not found: ${settings?.name} -> $error');
      // Fallback to login for unknown routes
      return MaterialPageRoute(
        builder: (_) => const LoginView(),
        settings: settings,
      );
    }
  }

  static Widget getPage(Routes route, {Object? arguments}) {
    switch (route) {
      case Routes.splash:
        return const SplashScreen();
      case Routes.login:
        return const LoginView();
      case Routes.otp:
        return const OtpView();
      case Routes.register:
        return const RegisterView();
      case Routes.home:
        return const HomeView();
    }
  }

  static Future<T?> pushNamed<T>(Routes route, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed<T>(
      route.path,
      arguments: arguments,
    );
  }

  static Future<T?> pushNamedAndRemoveAll<T>(
    Routes route, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
      route.path,
      (route) => false,
      arguments: arguments,
    );
  }

  static Future<T?> pushNamedAndRemoveUntilDashboard<T>(
    Routes route, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
      route.path,
      (pushNamed) => pushNamed.isFirst,
      arguments: arguments,
    );
  }

  static void popUntil<T>(Routes route) {
    return navigatorKey.currentState!.popUntil(ModalRoute.withName(route.path));
  }

  static void popUntilHome<T>() {
    return navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  static void pop<T>([T? result]) => navigatorKey.currentState!.pop<T>(result);
}
