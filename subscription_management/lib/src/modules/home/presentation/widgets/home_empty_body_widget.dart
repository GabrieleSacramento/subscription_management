import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subscription_management/src/routes/router.dart';
import 'package:subscription_management/src/utils/app_strings.dart';

class HomeEmptyBodyWidget extends StatelessWidget {
  final strings = SubscriptionsManagementStrings();

  HomeEmptyBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushRoute(const SelectStreamingPageRoute());
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/dinheiro.png',
              fit: BoxFit.cover,
              width: 100.h,
              height: 100.h,
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Text(
                strings.clickToAddSubscription,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color.fromRGBO(77, 77, 97, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
