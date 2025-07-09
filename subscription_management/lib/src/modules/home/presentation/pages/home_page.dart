import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subscription_management/src/modules/home/presentation/widgets/bottom_bar.dart';
import 'package:subscription_management/src/modules/home/presentation/widgets/home_filled_body_widget.dart';
import 'package:subscription_management/src/utils/app_strings.dart';

@RoutePage(name: 'HomePageRoute')
class HomePage extends StatelessWidget {
  final strings = SubscriptionsManagementStrings();
  final String? userName;

  HomePage({super.key, this.userName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 24.w,
          title: Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: Text(
              userName ?? strings.welcome,
              style: TextStyle(
                fontSize: 20.sp,
                color: const Color.fromRGBO(111, 86, 221, 1),
              ),
            ),
          ),
          backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
          elevation: 0,
        ),
        body: HomeFilledBodyWidget(),
        bottomNavigationBar: const BottomBar(),
      ),
    );
  }
}
