import 'package:auto_route/auto_route.dart';
import 'package:subscription_management/src/modules/splash_screen/splash_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class SubscriptionManagerRouter extends RootStackRouter {
  SubscriptionManagerRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashScreenRoute.page, initial: true),
  ];
}
