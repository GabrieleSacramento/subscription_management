import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import 'package:subscription_management/src/modules/home/presentation/widgets/my_subscription_info_widget.dart';
import 'package:subscription_management/src/modules/shared/widgets/value_spent_information_card.dart';
import 'package:subscription_management/src/modules/streaming_management/domain/entities/streaming_entity.dart';
import 'package:subscription_management/src/modules/streaming_management/presentation/cubit/streaming_management_cubit.dart';
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
  final _getStreamingCubit = GetIt.I.get<StreamingManagementCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getStreamingCubit..getStreamings(),
      child: SingleChildScrollView(
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

            BlocBuilder<StreamingManagementCubit, StreamingManagementState>(
              builder: (context, state) {
                return state.when(
                  onLoading:
                      () => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(111, 86, 221, 1),
                          ),
                        ),
                      ),
                  onFailure:
                      (error) => Center(
                        child: Text(
                          'Erro: $error',
                          style: TextStyle(fontSize: 14.sp, color: Colors.red),
                        ),
                      ),

                  onSuccess: (streamings) {
                    if (streamings.isEmpty) {
                      return Center(
                        child: Text(
                          strings.noSubscriptionsFound,
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: 8.h, bottom: 72.h),
                      itemCount: streamings.length,
                      itemBuilder: (context, index) {
                        final streaming = streamings[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: MySubscriptionInfoWidget(
                            onTap: () {
                              context.pushRoute(
                                StreamingManagementPageRoute(
                                  streaming: streaming,
                                  newStreaming: false,
                                ),
                              );
                            },

                            streamingServiceName: streaming.streamingName,
                            renewalDate:
                                streaming.renewalDate != null
                                    ? 'Renova em ${getDaysUntilRenewal(streaming.renewalDate!)} dias'
                                    : 'Data não definida',
                            subscriptionPrice: streaming.streamingValue,
                            seeDetails: true,
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
