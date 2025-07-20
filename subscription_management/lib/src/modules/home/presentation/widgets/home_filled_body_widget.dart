import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:subscription_management/src/modules/home/domain/enums/payment_method.dart';
import 'package:subscription_management/src/modules/home/presentation/widgets/my_subscription_info_widget.dart';
import 'package:subscription_management/src/modules/shared/widgets/value_spent_information_card.dart';
import 'package:subscription_management/src/modules/streaming_management/domain/entities/streaming_entity.dart';
import 'package:subscription_management/src/routes/router.dart';
import 'package:subscription_management/src/utils/app_strings.dart';
import 'package:subscription_management/src/utils/get_days_until_renewal.dart';

class HomeFilledBodyWidget extends StatefulWidget {
  final StreamingEntity? streamingEntity;

  const HomeFilledBodyWidget({super.key, this.streamingEntity});

  @override
  State<HomeFilledBodyWidget> createState() => _HomeFilledBodyWidgetState();
}

class _HomeFilledBodyWidgetState extends State<HomeFilledBodyWidget> {
  final strings = SubscriptionsManagementStrings();

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

          MySubscriptionInfoWidget(
            onTap: () {
              context.pushRoute(
                StreamingManagementPageRoute(
                  streaming: StreamingEntity(
                    streamingId: '1',
                    streamingName: 'Netflix',
                    streamingValue: 23.99,
                    renewalDate: DateTime.now().add(
                      Duration(
                        days: getDaysUntilRenewal(
                          widget.streamingEntity?.renewalDate ?? DateTime.now(),
                        ),
                      ),
                    ),
                    streamingImage: 'assets/logos/netflix.png',
                    paymentMethod: PaymentMethod.creditCard,
                  ),
                  newStreaming: false,
                ),
              );
            },
            streamingServiceImage: Image.asset(
              'assets/logos/netflix.png',
              width: 32.w,
              height: 32.h,
            ),
            streamingServiceName: 'Disney+',
            renewalDate: 'Renova em 20 dias',
            subscriptionPrice: 27.95,
            seeDetails: true,
          ),
        ],
      ),
    );
  }
}
