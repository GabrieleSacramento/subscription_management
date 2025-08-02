import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:subscription_management/src/modules/home/domain/enums/payment_method.dart';
import 'package:subscription_management/src/modules/shared/widgets/custom_form.dart';
import 'package:subscription_management/src/modules/streaming_management/presentation/widgets/dropdown_widget.dart';
import 'package:subscription_management/src/modules/streaming_management/presentation/widgets/streaming_form_controller.dart';
import 'package:subscription_management/src/utils/app_strings.dart';

class StreamingFormWidget extends StatelessWidget {
  final StreamingFormController controller;
  final Function(TextEditingController) onSelectDate;
  final VoidCallback onPaymentMethodChanged;

  const StreamingFormWidget({
    super.key,
    required this.controller,
    required this.onSelectDate,
    required this.onPaymentMethodChanged,
  });

  @override
  Widget build(BuildContext context) {
    final strings = SubscriptionsManagementStrings();

    return Column(
      children: [
        CustomForm(
          hintText: strings.name,
          isPrefixHint: true,
          controller: controller.nameController,
        ),
        CustomForm(
          hintText: strings.value,
          isPrefixHint: true,
          controller: controller.valueController,
          onChanged: controller.formatCurrency,
          keyboardType: TextInputType.number,
        ),
        CustomForm(
          hintText: strings.startsAt,
          isPrefixHint: true,
          suffixIcon: const Icon(Icons.calendar_month),
          controller: controller.startsAtController,
          isDatePicker: true,
          onTap: () => onSelectDate(controller.startsAtController),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: CustomForm(
            hintText: strings.renewAt,
            isPrefixHint: true,
            suffixIcon: const Icon(Icons.calendar_month),
            controller: controller.renewalDateController,
            isDatePicker: true,
            onTap: () => onSelectDate(controller.renewalDateController),
          ),
        ),
        DropdownWidget(
          isPaymentMethod: true,
          options: [strings.debitCard, strings.creditCard, strings.pix],
          onChanged: (value) {
            controller.updatePaymentMethod(value);
            onPaymentMethodChanged();
          },
          selectedValue: PaymentMethod.getStringFromPaymentMethod(
            controller.selectedPaymentMethod,
          ),
        ),
      ],
    );
  }
}
