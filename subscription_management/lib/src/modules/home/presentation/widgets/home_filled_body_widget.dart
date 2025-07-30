import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:subscription_management/src/modules/home/presentation/widgets/home_empty_body_widget.dart';

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

  double _calculateTotalSpent(List<StreamingEntity> streamings) {
    return streamings.fold(
      0.0,
      (total, streaming) => total + (streaming.streamingValue ?? 0.0),
    );
  }

  Widget _buildStreamingItem(StreamingEntity streaming) {
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
                ? formatRenewalDate(streaming.renewalDate!)
                : 'Data não definida',
        subscriptionPrice: streaming.streamingValue,
        seeDetails: true,
        renewalColor:
            streaming.renewalDate != null
                ? getRenewalColor(streaming.renewalDate!)
                : Colors.grey,
      ),
    );
  }

  Widget _buildTotalSpentCard(StreamingManagementState state) {
    final totalSpent = state.when(
      onLoading: () => 0.0,
      onFailure: (error) => 0.0,
      onSuccess: (streamings) => _calculateTotalSpent(streamings),
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.h),
      child: ValueSpentInformationCard(totalSpent: totalSpent),
    );
  }

  Widget _buildSectionTitle() {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        strings.mySubscriptions,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: const Color.fromRGBO(111, 86, 221, 1),
        ),
      ),
    );
  }

  Widget _buildStreamingsList(StreamingManagementState state) {
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
          return Padding(
            padding: EdgeInsets.only(top: 32.h),
            child: HomeEmptyBodyWidget(),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 8.h, bottom: 72.h),
          itemCount: streamings.length,
          itemBuilder:
              (context, index) => _buildStreamingItem(streamings[index]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getStreamingCubit..getStreamings(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            BlocBuilder<StreamingManagementCubit, StreamingManagementState>(
              builder: (context, state) => _buildTotalSpentCard(state),
            ),

            _buildSectionTitle(),

            BlocBuilder<StreamingManagementCubit, StreamingManagementState>(
              builder: (context, state) => _buildStreamingsList(state),
            ),
          ],
        ),
      ),
    );
  }
}
