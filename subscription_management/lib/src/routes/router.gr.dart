// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AddNewStreamingPage]
class AddNewStreamingPageRoute
    extends PageRouteInfo<AddNewStreamingPageRouteArgs> {
  AddNewStreamingPageRoute({
    Key? key,
    Widget? streamingImage,
    List<PageRouteInfo>? children,
  }) : super(
         AddNewStreamingPageRoute.name,
         args: AddNewStreamingPageRouteArgs(
           key: key,
           streamingImage: streamingImage,
         ),
         initialChildren: children,
       );

  static const String name = 'AddNewStreamingPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddNewStreamingPageRouteArgs>(
        orElse: () => const AddNewStreamingPageRouteArgs(),
      );
      return AddNewStreamingPage(
        key: args.key,
        streamingImage: args.streamingImage,
      );
    },
  );
}

class AddNewStreamingPageRouteArgs {
  const AddNewStreamingPageRouteArgs({this.key, this.streamingImage});

  final Key? key;

  final Widget? streamingImage;

  @override
  String toString() {
    return 'AddNewStreamingPageRouteArgs{key: $key, streamingImage: $streamingImage}';
  }
}

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
class SelectLoginMethodRoute extends PageRouteInfo<SelectLoginMethodRouteArgs> {
  SelectLoginMethodRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        SelectLoginMethodRoute.name,
        args: SelectLoginMethodRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'SelectLoginMethodRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SelectLoginMethodRouteArgs>(
        orElse: () => const SelectLoginMethodRouteArgs(),
      );
      return SelectLoginMethodPage(key: args.key);
    },
  );
}

class SelectLoginMethodRouteArgs {
  const SelectLoginMethodRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SelectLoginMethodRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SelectStreamingPage]
class SelectStreamingPageRoute extends PageRouteInfo<void> {
  const SelectStreamingPageRoute({List<PageRouteInfo>? children})
    : super(SelectStreamingPageRoute.name, initialChildren: children);

  static const String name = 'SelectStreamingPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SelectStreamingPage();
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
