import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subscription_management/src/modules/home/presentation/widgets/my_subscription_info_widget.dart';
import 'package:subscription_management/src/modules/shared/widgets/value_spent_information_card.dart';
import 'package:subscription_management/src/utils/app_strings.dart';

class HomeFilledBodyWidget extends StatelessWidget {
  final strings = SubscriptionsManagementStrings();
  HomeFilledBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32.h),
            child: const ValueSpentInformationCard(totalSpent: 55.90),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              strings.mySubscriptions,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(111, 86, 221, 1),
              ),
            ),
          ),

          // const MySubscriptionInfoWidget(
          //   streamingServiceImage: ,
          //   streamingServiceName: 'Disney+',
          //   renewalDate: 'Renova em 20 dias',
          //   subscriptionPrice: 27.95,
          //   seeDetails: true,
          // ),
        ],
      ),
    );
  }
}
