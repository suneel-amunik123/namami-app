// Small enum and helpers for app routes
enum PageDirection { leftToRight, rightToLeft, upToDown, downToUp, none }

enum Routes { splash, login, otp, register, home }

extension RoutesExtension on Routes {
  String get path {
    switch (this) {
      case Routes.splash:
        return '/splash';
      case Routes.login:
        return '/login';
      case Routes.otp:
        return '/otp';
      case Routes.register:
        return '/register';
      case Routes.home:
        return '/home';
    }
  }

  PageDirection get direction {
    // Use different directions if you want animated transitions per-route
    switch (this) {
      case Routes.splash:
        return PageDirection.none;
      case Routes.login:
        return PageDirection.leftToRight;
      case Routes.otp:
        return PageDirection.leftToRight;
      case Routes.register:
        return PageDirection.leftToRight;
      case Routes.home:
        return PageDirection.leftToRight;
    }
  }
}
