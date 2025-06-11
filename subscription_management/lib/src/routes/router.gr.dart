// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [HomePage]
class HomePageRoute extends PageRouteInfo<HomePageRouteArgs> {
  HomePageRoute({Key? key, String? userName, List<PageRouteInfo>? children})
    : super(
        HomePageRoute.name,
        args: HomePageRouteArgs(key: key, userName: userName),
        initialChildren: children,
      );

  static const String name = 'HomePageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomePageRouteArgs>(
        orElse: () => const HomePageRouteArgs(),
      );
      return HomePage(key: args.key, userName: args.userName);
    },
  );
}

class HomePageRouteArgs {
  const HomePageRouteArgs({this.key, this.userName});

  final Key? key;

  final String? userName;

  @override
  String toString() {
    return 'HomePageRouteArgs{key: $key, userName: $userName}';
  }
}

/// generated route for
/// [SelectLoginMethodPage]
class SelectLoginMethodRoute extends PageRouteInfo<void> {
  const SelectLoginMethodRoute({List<PageRouteInfo>? children})
    : super(SelectLoginMethodRoute.name, initialChildren: children);

  static const String name = 'SelectLoginMethodRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SelectLoginMethodPage();
    },
  );
}

/// generated route for
/// [SignupPage]
class SignupPageRoute extends PageRouteInfo<void> {
  const SignupPageRoute({List<PageRouteInfo>? children})
    : super(SignupPageRoute.name, initialChildren: children);

  static const String name = 'SignupPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignupPage();
    },
  );
}

/// generated route for
/// [SplashScreen]
class SplashScreenRoute extends PageRouteInfo<void> {
  const SplashScreenRoute({List<PageRouteInfo>? children})
    : super(SplashScreenRoute.name, initialChildren: children);

  static const String name = 'SplashScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen();
    },
  );
}
