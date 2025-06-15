import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subscription_management/src/utils/app_strings.dart';
import 'package:subscription_management/src/utils/formatters.dart';

class ValueSpentInformationCard extends StatelessWidget {
  const ValueSpentInformationCard({this.totalSpent, super.key});
  final num? totalSpent;

  @override
  Widget build(BuildContext context) {
    final strings = SubscriptionsManagementStrings();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      width: double.infinity,
      height: 110.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          width: 2,
          color: const Color.fromRGBO(111, 86, 221, 1),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: const Color.fromRGBO(111, 86, 221, 1),
            radius: 20.sp,
            child: Text(
              'R\$',
              style: TextStyle(fontSize: 20.sp, color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text(
              totalSpent != null
                  ? CurrencyFormatter.format(totalSpent!)
                  : CurrencyFormatter.format(127.90),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: const Color.fromRGBO(111, 86, 221, 1),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              strings.amountSpentThisMonth,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
                color: const Color.fromRGBO(77, 77, 97, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
