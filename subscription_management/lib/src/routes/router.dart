import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:subscription_management/src/modules/streaming_management/domain/entities/streaming_entity.dart';
import 'package:subscription_management/src/modules/login/presentation/pages/login_page.dart';
import 'package:subscription_management/src/modules/streaming_management/presentation/pages/streaming_management_page.dart';
import 'package:subscription_management/src/modules/home/presentation/pages/home_page.dart';
import 'package:subscription_management/src/modules/login/presentation/pages/select_login_method_page.dart';
import 'package:subscription_management/src/modules/select_streaming/presentation/pages/select_streaming_page.dart';
import 'package:subscription_management/src/modules/splash_screen/splash_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class SubscriptionManagerRouter extends RootStackRouter {
  SubscriptionManagerRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashScreenRoute.page, initial: true),
    AutoRoute(page: SelectLoginMethodRoute.page),
    AutoRoute(page: LoginPageRoute.page),
    AutoRoute(page: HomePageRoute.page),
    AutoRoute(page: SelectStreamingPageRoute.page),
    AutoRoute(page: StreamingManagementPageRoute.page),
  ];
}
