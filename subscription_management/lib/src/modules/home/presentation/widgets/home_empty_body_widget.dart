import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subscription_management/src/utils/app_strings.dart';

class HomeEmptyBodyWidget extends StatelessWidget {
  final strings = SubscriptionsManagementStrings();

  HomeEmptyBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/dinheiro.png',
              fit: BoxFit.cover,
              width: 127.h,
              height: 127.h,
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
